/*
 * En esta clase se encuentran el paginado, tambien la insercion de los datos en los objetos correspondientes
 * que recibimos cuando hacemos la llamado al servicio de agenda.
 * @param args[].
 * @return void.
*/
public with sharing class AgendaCallOutsTest {     
 /*
  * En esta metodo se encarga de realizar el paginado, recibe como parametros la pagina inicial que en este caso es uno y la pagina
  * final.
  * @param args[].
  * @return void.
  */    
    public static void getSerApp(Integer paginaInicial) {
        getPages(paginaInicial);
    }

    @future(callout=true)
    public static void getPages(Integer paginaInicial){
        List<ServiceAppointment> result = new List<ServiceAppointment>();
		integer contadorDePaginas = 0;
       	integer contadorDeRegistros = 0;	
           
        String response = IntegrationsServicePruebas.getAgendasResponse(String.valueOf(paginaInicial));
        AgendaModel.AgendaPagination models = new AgendaModel.AgendaPagination();
        models = AgendaModel.parsePagination(response);      
        createSchedules(paginaInicial, models.last_page);
    }
    
    public static void createSchedules(Integer pagInicial, Integer ultimaPagina){
        for(integer i = pagInicial; i <= ultimaPagina; i++){
            String type = 'callout';
            Datetime scheduleTime = Datetime.now().addSeconds(i*180);
            String hour = String.valueOf(scheduleTime.hour());
            String min = String.valueOf(scheduleTime.minute()); 
            String ss = String.valueOf(scheduleTime.second());
            
            //parse to cron expression
            String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
            AgendaSchedule s = new AgendaSchedule(String.valueOf(i), String.valueOf(ultimaPagina), type); 
            System.schedule('Schedule Agenda ' + String.valueOf(Datetime.now()) + ' callout - ' + 'page: ' + i, nextFireTime, s);

            if(i >= 90 && Math.mod(i, 90) == 0){
                break;
            }
        }
    }

    public static void beginInitialize(String page, String ultimaPagina){
        initializeServiceAppointments(page, ultimaPagina);
        if(Integer.valueOf(page) >= 90 && Math.mod(Integer.valueOf(page), 90) == 0){
            deleteJobs();
            Integer newPage = Integer.valueOf(page) + 1;
            createSchedules(newPage, Integer.valueOf(ultimaPagina));
        }
    }
    
    /*
    * En este metodo es estatico, y se ejecuta de forma asincronica es donde se realiza el mapeo de datos
    * insertan registros, recibiendo como parametro el paginado. 
    * @param args[string page].
    * @return void.
    */
    @future(callout=true)
    private static void initializeServiceAppointments(String page, String ultimaPagina) {

        Map<String, AgendaModel> mapIdPaciente = new Map<String, AgendaModel>();
        Set<String> profesionalesIds = new Set<String>();
        Map<String, AgendaModel> mapIdBoleta = new Map<String, AgendaModel>();
        Map<String, AgendaModel> mapIdServicio = new Map<String, AgendaModel>();
        
        System.debug('pagina::::' + page);
        try {
            String response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(page));
            List<AgendaModel> agendaModel = AgendaModel.parse(response);

            for (AgendaModel modelAux : agendaModel) { 
                mapIdPaciente.put(modelAux.id_patient, modelAux);			    
                profesionalesIds.add(modelAux.id_staff);
                mapIdBoleta.put(modelAux.id_order, modelAux);
                mapIdServicio.put(modelAux.attention.code, modelAux);
            }
            
            Map<String, Contact> mapContToInsert = new Map<String, Contact>();
            List<ServiceAppointmentWrapper> serviceAppointmentsWrapper = new List<ServiceAppointmentWrapper>();
            Map<String, Account> accountByNumeroDeId = new Map<String,Account>();
            Map<String, Account> accountById = getAccountsByIdPaciente(mapIdPaciente);
            Map<String, Contact> contactById = ProfesionalesHandler.getContactByNumeroDeId(profesionalesIds);
            Map<String, Id> ProductById = getProductByCodeId(mapIdServicio);

            for (AgendaModel model : agendaModel) {
                String idPaciente = model.id_patient;
                
                ServiceAppointmentWrapper wrapper = new ServiceAppointmentWrapper();
                setDefaultFields(model);
                ProfessionalModel profesional = model.staff;
                
                wrapper.service = getServAppFromParser(model);
                wrapper.service.Boleta_Order__c = model.id_order != null ? String.valueOf(model?.id_order) : null;

                wrapper.cuenta = accountById.containsKey(idPaciente)
                    ? accountById.get(idPaciente)
                    : PacienteHandler.getAccountFromPatientModel(model.patient);
                
                if (wrapper.cuenta.Id == null && String.isBlank(String.valueOf(wrapper.cuenta.Id)) && wrapper.cuenta != null)
                {
                    accountByNumeroDeId.put(wrapper.cuenta.Id_Paciente__c, wrapper.cuenta);
                }
                if(profesional.doc_type.code != null && model.id_staff != null){
                    wrapper.profesional = contactById.containsKey(model.id_staff)
                        ? contactById.get(model.id_staff)
                        : null;
                }
                    
                wrapper.codigoDeConvenio = model.insurance_plan?.code;
                
                wrapper.productCode = model.attention?.code;
                
                serviceAppointmentsWrapper.add(wrapper);
            }
            
            system.debug('WRAPPER SIZE:::' + serviceAppointmentsWrapper.size());
        
            List<ServiceAppointment> servApp = getServiceAppointments(serviceAppointmentsWrapper, accountByNumeroDeId, mapIdBoleta, mapIdPaciente, mapContToInsert, ProductById, agendaModel, page);
        
            Map<String,ServiceAppointment> mapServAppToUpsert = new Map<String,ServiceAppointment>();
            for(ServiceAppointment serv : servApp){
                if(mapServAppToUpsert.containsKey(serv.Id_Agenda__c) && mapServAppToUpsert.get(serv.Id_Agenda__c) != null){
                    if(mapServAppToUpsert.get(serv.Id_Agenda__c).Fecha_y_Hora_agenda__c < serv.Fecha_y_Hora_agenda__c){
                        mapServAppToUpsert.remove(serv.Id_Agenda__c);
                    }else{
                        continue;
                    }
                }
                mapServAppToUpsert.put(serv.Id_Agenda__c, serv);
            }
            system.debug('cantidad Agenda Upsert::::' + mapServAppToUpsert.values().size());
            List<Database.upsertResult> uResults = Database.upsert(mapServAppToUpsert.values(), ServiceAppointment.Id_Agenda__c, false);
            List<Id> idsCreated = new List<Id>();
            List<Id> idsSuccess = new List<Id>();
            List<Error_Log__c> listErrors = new List<Error_Log__c>();
            for(Integer i = 0; i < uResults.size(); i++) {
                if (!uResults[i].isSuccess()) {
                    for(Database.Error err : uResults[i].getErrors()) {
                        Error_Log__c error = new Error_Log__c(
                            Error_Date_Time__c = DateTime.now(),
                            Running_User__c = Userinfo.getUserId(),
                            Error_Message__c = 'For the Agenda: ' + mapServAppToUpsert.values()[i] + '; With the Id: ' + mapServAppToUpsert.values()[i].Id_Agenda__c + '; From the page: ' + page +'; The following error has occurred: ' + err.getMessage(),
                            Stack_Trace__c = err.getStatusCode() + ' Fields that affected this error: ' + err.getFields()
                        );
                        listErrors.add(error);
                    }
                }else if(uResults[i].isSuccess() && uResults[i].isCreated()){
                    idsCreated.add(uResults[i].getId());
                }else if(uResults[i].isSuccess()){
                    idsSuccess.add(uResults[i].getId());
                }
            }
            if(!listErrors.isEmpty()){
                insert listErrors;
            }
            System.debug('Agendas Created: ' + idsCreated.size());
            System.debug('Agendas Success: ' + idsSuccess.size());

            if(page == ultimaPagina){
                deleteJobs();
                Datetime scheduleTime = Datetime.now().addSeconds(60);
                String hour = String.valueOf(scheduleTime.hour());
                String min = String.valueOf(scheduleTime.minute()); 
                String ss = String.valueOf(scheduleTime.second());
                
                //parse to cron expression
                String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
                BoletaQuirurgicaSchedule s = new BoletaQuirurgicaSchedule(); 
                System.schedule('Schedule Boletas ' + String.valueOf(Datetime.now()) + ' callout', nextFireTime, s);
            }
        } catch (Exception ex) {
            createErrors(ex);
            deleteJobs();
        }
    }

    /*
  * En este metodo es estatico, y se ejecuta de forma asincronica es donde se realiza el mapeo de datos
  * insertan registros, recibiendo como parametro el paginado. 
  * @param args[string page].
  * @return void.
   */
    private static List<ServiceAppointment> getServiceAppointments(List<ServiceAppointmentWrapper> serviceAppointmentsWrapper, Map<String, Account> accountByNumeroDeId,
                                                                  Map<String, AgendaModel> boletaInput , Map<String, AgendaModel> pacientes, Map<String, Contact> mapContToInsert,
                                                                  Map<String, Id> ProductById, List<AgendaModel> accountsId, String page) {

        List<ServiceAppointment> result = new List<ServiceAppointment>();
        List<Account> listAccToUpsert = new List<Account>();
        Map<String, Id> mapAccsCreated = new Map<String, Id>();
		                                                              
        if (!serviceAppointmentsWrapper.isEmpty()) {

            Map<ServiceAppointmentWrapper, Convenios_de_paciente__c> convenidoByWrapper = new Map<ServiceAppointmentWrapper, Convenios_de_paciente__c>();
                                                                         
            try {
    
                Map<String, Id> convenioIDByCode = getConvenioIDByCode(serviceAppointmentsWrapper);
    
                System.debug('****accountByNumeroDeId: '+accountByNumeroDeId.size());
                
                if (!accountByNumeroDeId.values().isEmpty()){
                    Map<String, Account> mapAccToUpsert = new Map<String, Account>();
                    for(Account acc : accountByNumeroDeId.values()){
                        if(mapAccToUpsert.containsKey(acc.Id_Paciente__c)){
                            continue;
                        }else{
                            mapAccToUpsert.put(acc.Id_Paciente__c, acc);
                        }
                    }
                    listAccToUpsert = mapAccToUpsert.values();
                    List<Database.upsertResult> uResults = Database.upsert(listAccToUpsert, Account.Id_Paciente__c, false);
                    List<Error_Log__c> listErrors = new List<Error_Log__c>();
                    for(Integer i = 0; i < uResults.size(); i++) {
                        if (!uResults[i].isSuccess()) {
                            for(Database.Error err : uResults[i].getErrors()) {
                                Error_Log__c error = new Error_Log__c(
                                    Error_Date_Time__c = DateTime.now(),
                                    Running_User__c = Userinfo.getUserId(),
                                    Error_Message__c = 'From the page: ' + page + '; For the Account: ' + listAccToUpsert[i] + '; With the Id: ' + listAccToUpsert[i].Id_Paciente__c + '; The following error has occurred: ' + err.getMessage(),
                                    Stack_Trace__c = err.getStatusCode() + ' Fields that affected this error: ' + err.getFields()
                                );
                                listErrors.add(error);
                            }
                        }
                    }
                    insert listErrors;
                    //upsert listAccToUpsert Account.Id_Paciente__c;
                    for(Account acc : listAccToUpsert){
                        mapAccsCreated.put(acc.Id_Paciente__c, acc.Id);
                    }
                }
                for (ServiceAppointmentWrapper wrapper: serviceAppointmentsWrapper) {
                    
                    wrapper.service.servicio__c = ProductById.get(wrapper.productCode);
    
                    if (wrapper.codigoDeConvenio != null && convenioIDByCode.containsKey(wrapper.codigoDeConvenio) && wrapper.cuenta.Id != null) {
                        Convenios_de_paciente__c convenio = new Convenios_de_paciente__c(
                            Paciente__c = wrapper.cuenta.Id,
                            Convenio__c = convenioIDByCode.get(wrapper.codigoDeConvenio));
                        convenidoByWrapper.put(wrapper, convenio);
                    }
    
                    wrapper.service.ParentRecordId = wrapper?.cuenta?.Id != null ? wrapper?.cuenta?.Id : mapAccsCreated.get(wrapper?.cuenta?.Id_Paciente__c);
                    wrapper.service.Profesional__c = wrapper.profesional != null ? wrapper.profesional.Id : null;
                    result.add(wrapper.service);
                }
                
                if(!convenidoByWrapper.isEmpty()){
                    insert convenidoByWrapper.values();
                    for(ServiceAppointmentWrapper wrapper : convenidoByWrapper.keySet()){
                        wrapper.service.Convenio_de_paciente__c = convenidoByWrapper.get(wrapper).Id;
                    }
                }
    
            }catch (Exception ex) {
                System.debug('Error: ' + ex.getMessage() + ' ' + ex.getStackTraceString());
                createErrors(ex);
                deleteJobs();
            }
        }
        return result;
    }

    /*
  * En este metodo se recibe como parametro un objeto de tipo de AgendaModel, donde se setean todos los campos
  * con los valores que se mapearon previamente.
  * de una agenda. 
  * @param args[AgendaModel model].
  * @return void.
   */
    private static void setDefaultFields(AgendaModel model) {
        model.patient.id_patient = model.id_patient;
        model.staff.id_staff = model.id_staff;
        model.patient.doc = model.patient.doc_number;
        model.patient.tdoc = model.patient.doc_type;
        model.patient.names = model.patient.name;
        model.patient.last_name = model.patient.paternal_surname;
        model.patient.mother_last_name = model.patient.maternal_surname;
        model.patient.country_residence = model.patient.country_origin;
        model.patient.city_residence = model.patient.city_origin;
    }

    /*
  * Este metodo se encarga de realizar una consulta a la base de datos de SF para verificar si los pacientes existen,
	recibe como parametro una lista de pacientes y retorna el id del paciente, si existe.
  * @param args[Map<String, AgendaModel> pacientes].
  * @return id_paciente.
   */
    private static Map<String, Account> getAccountsByIdPaciente(Map<String, AgendaModel> pacientes) {
        Map<String,Account> result = new Map<String,Account>();

        for (Account acc : [SELECT Id, Id_Paciente__c FROM Account WHERE Id_Paciente__c  IN : pacientes.keySet()])
            result.put(acc.Id_Paciente__c, acc);

        return result;
    }

    /*
  * Este metodo se encarga de realizar una consulta a la base de datos de SF para verificar si los servicios existen,
  * recibe como parametro una lista de servicios y retorna el id del producto, si existe.
  * @param args[Map<String, AgendaModel> servicios].
  * @return producto.id.
   */
    private static Map<String, Id> getProductByCodeId(Map<String, AgendaModel> servicios) {
        Map<String, Id> result = new Map<String, Id>();

        for (Product2 producto :
                [SELECT Id, ProductCode FROM Product2 WHERE ProductCode  IN: servicios.keySet()])
            result.put(producto.ProductCode, producto.Id);

        return result;
    }
    
    /*
  * Este metodo se encarga de realizar una consulta a la base de datos de SF para verificar si los convenios existen,
  * recibe como parametro una lista de convenios y retorna los id de convenios, si existe.
  * @param args[List<ServiceAppointmentWrapper> serviceAppointmentsWrapper].
  * @return convenio.id.
   */
    private static Map<String, Id> getConvenioIDByCode(List<ServiceAppointmentWrapper> serviceAppointmentsWrapper) {
        Set<String> codigosConvenio = new Set<String>();
        Map<String, Id> result = new Map<String, Id>();

        for(ServiceAppointmentWrapper singleWrapper : serviceAppointmentsWrapper) {

            if (singleWrapper.codigoDeConvenio == null){
                continue;
            }else{
                codigosConvenio.add(singleWrapper.codigoDeConvenio);
            } 

        }

        for(HealthCloudGA__EhrCarePlan__c convenio : [SELECT Id, Codigo_de_convenio_plan__c FROM HealthCloudGA__EhrCarePlan__c WHERE Codigo_de_convenio_plan__c  IN : codigosConvenio]){
            result.put(convenio.Codigo_de_convenio_plan__c, convenio.Id);
        }

        return result;
    }

    /**
    * @date 2022-06-10
    *
    * @object ServiceAppoitment
    *
    * @descripcion Retorna un nuevo service appointment parsea los campos del objeto AgendaModel 
    */
    private static ServiceAppointment getServAppFromParser(AgendaModel model) {
        AgendaModel.Building building = model.location?.building != null ? model.location?.building : null;
        List<String> dateComponents = String.valueOf(model.date_appoinment).split('-');
        List<String> hourComponent = String.valueOf(model.hour_appoinment).split(':');
        Integer year = Integer.valueOf(dateComponents[0]);
        Integer month = Integer.valueOf(dateComponents[1]);
        Integer day = Integer.valueOf(dateComponents[2]);
        Integer hour = Integer.valueOf(hourComponent[0]);
        Integer minute = Integer.valueOf(hourComponent[1]);
        System.debug('attention type ' +model.attention.type.detail);
        return new ServiceAppointment(
            Id_Agenda__c = model.form_number != null ? String.valueOf(model.form_number) : null,
            Fecha_y_Hora_agenda__c = Datetime.newInstance(year, month, day, hour, minute, 0),
            Status = model.status?.detail != null ? String.valueOf(model.status?.detail) : null,
            Codigo_sede__c = building?.code != null ? String.valueOf(building?.code) : null,
            Nombre_sede__c = building?.detail != null ? String.valueOf(building?.detail) : null,
            Ciudad_sede__c = building?.city?.detail != null ? String.valueOf(building?.city?.detail) : null,
            Direccion_sede__c = building.Address != null ? String.valueOf(building?.Address) : null,
            Tipo_de_prestacion__c = model.attention.type.code != null ? String.valueOf(model?.attention?.type.code) : null,
            Valor_de_servicio__c = model.attention.cost != null ? Integer.valueOf(model?.attention?.cost) : null
        );
    }

    public static void createErrors(Exception ex){
        List<Error_Log__c> listErrors = new List<Error_Log__c>();
        Error_Log__c error = new Error_Log__c(
            Error_Date_Time__c = DateTime.now(),
            Running_User__c = Userinfo.getUserId(),
            Error_Message__c ='The following error has occurred: ' + ex.getMessage(),
            Stack_Trace__c = ex.getStackTraceString()
        );
        listErrors.add(error);
        insert listErrors;
    }

    public static void deleteJobs(){
        for(CronTrigger delCron: [SELECT CronJobDetail.Name, CronExpression, OwnerId FROM CronTrigger WHERE CronJobDetail.JobType = '7' AND CronJobDetail.Name LIKE '%Schedule Agenda%']) {
            System.abortJob(delCron.Id);
        }
    }

    /*
        * Este metodo es uno contenedor, donde se encuentran los objetos serviceAppointment, Account, Contact y Boleta.
        * @param args[].
        * @return void.
    */
    private class ServiceAppointmentWrapper {
        ServiceAppointment service;
        Account cuenta;
        Contact profesional;
        HealthCloudGA__EHRProcedureRequest__c boleta;
        String codigoDeConvenio;
        String productCode;
    }
}