public class AgendaCallOutPruebas {   
    //@future(callout=true)
    public static integer page = 1;

    
    public static void getSerApp() {
        List<ServiceAppointment> result = new List<ServiceAppointment>();
		integer contadorDePaginas = 0;
       	integer contadorDeRegistros = 0;	
        integer last_page = 0;
        
        String response = IntegrationsService.getAgendasResponse();
        
        AgendaModel.AgendaPagination models = new AgendaModel.AgendaPagination();
      
        models = AgendaModel.parsePagination(response);
     	last_page = models.last_page; 		      
        system.debug('MODELS::::::::'+models);
      
        for(integer i = last_page; i > 0; i--){
           contadorDeRegistros++;
           if(contadorDeRegistros == 30){
               response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(i));   
               ejecutarProceso(response);
              }
           }
           if(contadorDeRegistros > 0){
                contadorDePaginas++;
               	system.debug('CONTADORDEPAGINAS:::::'+contadorDePaginas);
                response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(contadorDePaginas));   
                ejecutarProceso(response);
            } 
            
        } 
            
            
            
            /*  if(contadorDeRegistros == 30){
               contadorDePaginas++;
               response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(contadorDePaginas));   
               ejecutarProceso(response);
              }
           }
           if(contadorDeRegistros > 0){
                contadorDePaginas++;
                response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(contadorDePaginas));   
                ejecutarProceso(response);
            } 
        }*/
        
        /*  for(AgendaModel modelsAux : models){
           contadorDeRegistros++;	
           if(contadorDeRegistros == 30){
               contadorDePaginas++;
               response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(contadorDePaginas));   
               ejecutarProceso(response);
           }
       }
       if(contadorDeRegistros > 0){
          contadorDePaginas++;
          response = IntegrationsServicePruebas.getAgendasResponse(String.ValueOf(contadorDePaginas));   
          ejecutarProceso(response);
       }
        */
    

    public static void ejecutarProceso(String response) {
        
        List<AgendaModel> models = new List<AgendaModel>();
        models = AgendaModel.parse(response);
        
        integer contadorDeRegistros = 0;
        integer indexInicial = 0;
        integer indexFinal = -1;
        
        for (AgendaModel model : models) {
			setDefaultFields(model);    
            contadorDeRegistros++;    
            
            if(contadorDeRegistros == 30){ // La cantidad de registros que se recibe se limita a 30, para no pasar el limite de los callouts
                indexFinal = indexFinal + contadorDeRegistros;
                system.debug('index:::' + indexInicial + '-' + indexFinal + '-' + contadorDeRegistros);
                initializeServiceAppointments(response, indexInicial, indexFinal);
                indexInicial = indexInicial + contadorDeRegistros;
                contadorDeRegistros = 0;
        	}
        }
        if(contadorDeRegistros > 0){
            indexFinal = indexFinal + contadorDeRegistros;
            system.debug('index:::' + indexInicial + '-' + indexFinal + '-' + contadorDeRegistros);
            initializeServiceAppointments(response, indexInicial, indexFinal);
         }
    }
    
    @future(callout=true)
    private static void initializeServiceAppointments(String response, Integer offSetInicio, Integer offSetFinal) {

        Map<String, AgendaModel> mapIdPaciente = new Map<String, AgendaModel>();
        Set<String> profesionalesIds = new Set<String>();
        Map<String, AgendaModel> mapIdBoleta = new Map<String, AgendaModel>();
        
        List<AgendaModel> agendaModel = AgendaModel.parse(response);
        List<AgendaModel> agendaModelAEjecutar = New List<AgendaModel>();
        Integer row = 0;
        for (AgendaModel modelAux : agendaModel) { 
            if(offSetInicio <= row && row <= offSetFinal)
            {
                system.debug(modelAux.id_patient);
                agendaModelAEjecutar.add(modelAux);
            	//setDefaultFields(modelAux);    
                mapIdPaciente.put(modelAux.id_patient, modelAux);			    
                profesionalesIds.add(modelAux.staff.id_staff);
            	mapIdBoleta.put(modelAux.id_order, modelAux);
                system.debug('ROW::' + row);
            }
            row++;
        }
        system.debug('ROWS:::' + row);
        system.debug('PacienteList**************'+mapIdPaciente);
        system.debug('PacienteList**************SIZE'+mapIdPaciente.size());
        system.debug('ProfesionalesList**************'+mapIdPaciente);
        system.debug('BoletaList**************'+mapIdPaciente);
        
    	Map<String, Contact> mapContToInsert = new Map<String, Contact>();
        List<ServiceAppointmentWrapper> serviceAppointmentsWrapper = new List<ServiceAppointmentWrapper>();
        Map<String, Account> accountByNumeroDeId = new Map<String,Account>();
        Map<String, Account> accountById = getAccountsByIdPaciente(mapIdPaciente);
        Map<String, Contact> contactById = ProfesionalesHandler.getContactByNumeroDeId(profesionalesIds);

        system.debug('Cantidad Agenda:::' + agendaModelAEjecutar.size());
        //for (String idPaciente : mapIdPaciente.keySet()) {
		for (AgendaModel modelAux : agendaModelAEjecutar) {
            String idPaciente = modelAux.id_patient;
            
            ServiceAppointmentWrapper wrapper = new ServiceAppointmentWrapper();
            AgendaModel model = modelAux;// mapIdPaciente.get(idPaciente);
            setDefaultFields(model);
            ProfessionalModel profesional = model.staff;
            
            system.debug(model.patient);
            system.debug(profesional);
            
            wrapper.service = getServAppFromParser(model);
        
            wrapper.cuenta = accountById.containsKey(idPaciente)
                ? accountById.get(idPaciente)
                : PacienteHandler.getPaciente(model?.patient?.doc_number, model?.patient?.tdoc?.code);
				//System.debug('PacienteeeID::::::.'+model.patient.doc_number+'PacienteDoc:::::'+model.patient.tdoc.code);
            
            if (wrapper.cuenta?.Id == null)
                accountByNumeroDeId.put(wrapper.cuenta.Numero_de_ID__c, wrapper.cuenta);
	
            System.debug('Professional:::::::'+profesional);
            if(profesional.doc_type.code != null && model.id_staff != null){
            	wrapper.profesional = contactById.containsKey(model.id_staff)
                	? contactById.get(model.id_staff)
                	: ProfesionalesHandler.getProfesional(model.id_staff, profesional.doc_type.code);
                	//system.debug('ProfesionalesID::::::'+profesional.id_staff + 'ProfesionaalessDoc::::' + profesional.doc_type.code);
            }
            	
            if (wrapper.profesional?.Id == null && wrapper.profesional.Numero_de_ID__c != null)
                mapContToInsert.put(wrapper.profesional.Numero_de_ID__c, wrapper.profesional);
				
            wrapper.codigoDeConvenio = model.insurance_plan?.code;                

            serviceAppointmentsWrapper.add(wrapper);
        }
        
        system.debug('WRAPPER SIZE:::' + serviceAppointmentsWrapper.size());
        List<ServiceAppointment> servApp = getServiceAppointments(serviceAppointmentsWrapper, accountByNumeroDeId, mapIdBoleta, mapIdPaciente, mapContToInsert);
        
        try {
            upsert servApp ServiceAppointment.Id_Agenda__c;  // This line upserts the assets list with
                                            // the Line_Item_Id__c field specified as the 
                                            // Asset field that should be used for matching
                                            // the record that should be upserted. 
        } catch (DmlException e) {
            System.debug(e.getMessage());
        }
    }

    private static List<ServiceAppointment> getServiceAppointments(List<ServiceAppointmentWrapper> serviceAppointmentsWrapper, Map<String, Account> accountByNumeroDeId,
                                                                  Map<String, AgendaModel> boletaInput , Map<String, AgendaModel> pacientes, Map<String, Contact> mapContToInsert) {

        List<ServiceAppointment> result = new List<ServiceAppointment>();

        if (serviceAppointmentsWrapper.isEmpty()) return result;

        List<Account> accounts = accountByNumeroDeId.values();
        List<Contact> contacts = mapContToInsert.values();
        Map<ServiceAppointmentWrapper, Convenios_de_paciente__c> convenidoByWrapper = new Map<ServiceAppointmentWrapper, Convenios_de_paciente__c>();
        List<Contact> profesionalesAux = new List<Contact>();
                                                                      
        try {

            Map<String, HealthCloudGA__EHRProcedureRequest__c> boletas = getBoletasByIdBoletaQ(boletaInput.keySet());

            Map<String, Id> convenioIDByCode = getConvenioIDByCode(serviceAppointmentsWrapper);

            BoletaQuirurgicaHandler handler = new BoletaQuirurgicaHandler(pacientes.values(), boletas);

            system.debug('BoletaProfesionales:::::'+ contacts);
            contacts.addAll(handler.getContacts());

            for(Contact contactAux : contacts){
                Boolean exist = false;
                for (Contact contactAuxAdd : profesionalesAux)
                {
                    if (contactAux.Numero_de_ID__c == contactAuxAdd.Numero_de_ID__c)
                    {
                        exist = true;
                    	continue;
                    }
                }
                if (!exist)
                    profesionalesAux.add(contactAux);               
            }
            
            
            if (!accounts.isEmpty()) upsert accounts Id_Paciente__c;

            if (!contacts.isEmpty()) upsert profesionalesAux Numero_de_ID__c;

            handler.insertConvenios(convenioIDByCode);
            handler.insertBoletas();
            handler.insertAttention();
            handler.updateMap();

            for (ServiceAppointmentWrapper wrapper: serviceAppointmentsWrapper) {
				if (wrapper.service.Id_Agenda__c == null) continue;
                if (!accounts.isEmpty()) wrapper.service.ParentRecordId = wrapper.cuenta.Id;
                if (!contacts.isEmpty()) wrapper.service.Profesional__c = wrapper.profesional.Id;
                Id idBoleta = boletas.get(wrapper.cuenta.Id_Paciente__c)?.Id;
                if (idBoleta != null) wrapper.service.Detalles_Boleta_Quirurgica__c = idBoleta;

                System.debug(wrapper.codigoDeConvenio);
                System.debug(convenioIDByCode);              

                if (wrapper.codigoDeConvenio != null && convenioIDByCode.containsKey(wrapper.codigoDeConvenio)) {
                    Convenios_de_paciente__c convenio = new Convenios_de_paciente__c(
                        Paciente__c = wrapper.cuenta.Id,
                        Convenio__c = convenioIDByCode.get(wrapper.codigoDeConvenio));
                    convenidoByWrapper.put(wrapper, convenio);
                }

                wrapper.service.ParentRecordId = wrapper?.cuenta?.Id;
                wrapper.service.Profesional__c = wrapper?.profesional?.Id;
                wrapper.service.Detalles_Boleta_Quirurgica__c = wrapper?.boleta?.Id;                

                result.add(wrapper.service);
            }
            //if (!convenios.isEmpty()) insert convenios;

            if(!convenidoByWrapper.isEmpty()){
                insert convenidoByWrapper.values();
                
                for (ServiceAppointmentWrapper wrapper : convenidoByWrapper.keySet())
                    wrapper.service.Convenio_de_paciente__c = convenidoByWrapper.get(wrapper).Id;
            }

            System.debug('convenidoByWrapper'+convenidoByWrapper);

        } catch (DmlException ex) {
            System.debug('Error: ' + ex.getMessage());
        }

        return result;
    }

    private static void setDefaultFields(AgendaModel model) {
        model.patient.id_patient = model.id_patient;
        model.staff.id_staff = model.id_staff;
        model.staff.id_staff = model.id_staff;
        //model.boleta.id_order = model.boleta.id_order;
        //model.patient.doc_number = model.patient.doc_number; TODO
        model.patient.tdoc = model.patient.doc_type;
        model.patient.name = model.patient.names;
        model.patient.last_name = model.patient.paternal_surname;
        model.patient.mother_last_name = model.patient.maternal_surname;
    }

    private class ServiceAppointmentWrapper {
        ServiceAppointment service;
        Account cuenta;
        Contact profesional;
        HealthCloudGA__EHRProcedureRequest__c boleta;
        String codigoDeConvenio;
    }

    private static Map<String, Account> getAccountsByIdPaciente(Map<String, AgendaModel> pacientes) {
        Map<String,Account> result = new Map<String,Account>();

        for (Account acc : [SELECT Id, Id_Paciente__c FROM Account WHERE Id_Paciente__c  IN : pacientes.keySet()])
            result.put(acc.Id_Paciente__c, acc);

        return result;
    }

    private static Map<String, Id> getConvenioIDByCode(List<ServiceAppointmentWrapper> serviceAppointmentsWrapper) {
        Set<String> codigosConvenio = new Set<String>();
        Map<String, Id> result = new Map<String, Id>();

        for(ServiceAppointmentWrapper singleWrapper : serviceAppointmentsWrapper) {

            if (singleWrapper.codigoDeConvenio == null) continue;

            codigosConvenio.add(singleWrapper.codigoDeConvenio);
        }

        for(HealthCloudGA__EhrCarePlan__c convenio :
                [SELECT Id, Codigo_de_convenio_plan__c FROM HealthCloudGA__EhrCarePlan__c WHERE Codigo_de_convenio_plan__c  IN : codigosConvenio])
            result.put(convenio.Codigo_de_convenio_plan__c, convenio.Id);

        return result;
    }

    private static Map<String, HealthCloudGA__EHRProcedureRequest__c> getBoletasByIdBoletaQ(Set<String> idsSet) {
        Map<String, HealthCloudGA__EHRProcedureRequest__c> result =
            new Map<String, HealthCloudGA__EHRProcedureRequest__c>();

        for (HealthCloudGA__EHRProcedureRequest__c boletaq :
                [SELECT Id, Id_BoletaQ__c FROM HealthCloudGA__EHRProcedureRequest__c WHERE Id_BoletaQ__c IN : idsSet])
            result.put(boletaq.Id_BoletaQ__c, boletaq);

        return result;
    }

    private static ServiceAppointment getServAppFromParser(AgendaModel model) {
        AgendaModel.Building building = model.location?.building;
        List<String> dateComponents = String.valueOf(model.date_appoinment).split('-');
        List<String> hourComponent = String.valueOf(model.hour_appoinment).split(':');
        Integer year = Integer.valueOf(dateComponents[0]);
        Integer month = Integer.valueOf(dateComponents[1]);
        Integer day = Integer.valueOf(dateComponents[2]);
        Integer hour = Integer.valueOf(hourComponent[0]);
        Integer minute = Integer.valueOf(hourComponent[1]);

        return new ServiceAppointment(
            Id_Agenda__c = String.valueOf(model.form_number),
            Fecha_y_Hora_agenda__c = Datetime.newInstance(year, month, day, hour, minute, 0),
            Status = String.valueOf(model.status?.detail),
            Codigo_sede__c = String.valueOf(building?.code),
            Nombre_sede__c = String.valueOf(building?.detail),
            Ciudad_sede__c = String.valueOf(building?.city?.detail),
            Direccion_sede__c = String.valueOf(building?.Address)
            //Valor_de_servicio__c = decimal.valueOf(agenda?.attention?.cost)
        );
    }

}