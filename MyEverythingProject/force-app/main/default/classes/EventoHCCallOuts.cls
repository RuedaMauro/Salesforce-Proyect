public class EventoHCCallOuts {
    public static integer page = 1;
	public static integer maxPage = 50;
 
   public static void initializeEventosPagination(Integer paginaInicial, Integer paginaFinal){
		integer contadorDePaginas = 0;
       	integer contadorDeRegistros = 0;	
        integer last_page = 0;
               
        if (paginaFinal == 1){
            String response = IntegrationsServicePruebas.getEvents(String.valueOf(paginaInicial));
			system.debug('PAGINA::::::::'+paginaFinal);

            EventoModel.EventoPagination models = new EventoModel.EventoPagination();
			system.debug('PAGINA2::::::::'+paginaFinal);
            models = EventoModel.parsePagination(response);
            system.debug('MODELS::::::::'+models);

            last_page = models.last_page;
        }
        else{
            last_page = paginaFinal;
        }
      	
        Boolean ejecutarBatch = false;
        Integer limiteFor;
        Integer totalPaginas = last_page - paginaInicial;
        
        if (totalPaginas > maxPage){
			limiteFor = paginaInicial + maxPage - 1;
            ejecutarBatch = true;
        }
        else{
            limiteFor = last_page + 1;
        }
        System.debug('TOTAL PAGINAS:::'+totalPaginas);
        System.debug('LAST PAGE:::'+ last_page);
        System.debug('PAGINA INICIAL:::'+ paginaInicial);
        System.debug('LIMITE FOR:::'+ limiteFor);
        System.debug('EJECUTAR BATCH:::' + ejecutarBatch);
       
        for(integer i = paginaInicial; i < limiteFor; i++){
               initializeEventoBatch(String.valueOf(i));
        }
        
        System.debug('Ejecutar Batch:::' + ejecutarBatch);
        if (ejecutarBatch){
            System.debug('Creación del Schedule');
            
            String hour = String.valueOf(Datetime.now().hour());
            String min = String.valueOf(Datetime.now().minute() + 1); 
            String ss = String.valueOf(Datetime.now().second());
            
            //parse to cron expression
            String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
            
            EventoHCSchedule s = new EventoHCSchedule(limiteFor, last_page); 
            System.schedule('Schedule evento' + String.valueOf(Datetime.now()), nextFireTime, s);
        }
       
   }
    
   @future(callout=true) 
   public static void initializeEventoBatch(string pageEventoHC) {
        
        System.debug('pagina::::' + pageEventoHC);
        String response = IntegrationsServicePruebas.getEvents(String.ValueOf(pageEventoHC));
        List<EventoModel> models = EventoModel.parse(response);
        
        Map<String, EventoModel> mapIdPaciente = new Map<String, EventoModel>();
        Map<String, EventoModel> mapIdProfesional = new Map<String, EventoModel>();
        Set<String> profesionalesIds = new Set<String>();
        Map<String, EventoModel> mapIdTutor = new Map<String, EventoModel>();
        Map<String, Account> mapAccToInsert = new Map<String, Account>();
        Map<String, Contact> mapContToInsert = new Map<String, Contact>();
        Map<String, Account> mapTutorToInsert = new Map<String, Account>();
        List<EventoHCWrappper>  listWrapper = new List<EventoHCWrappper>();
		List<EventoHCWrappper>  listWrapperAux = new List<EventoHCWrappper>();

       
        for(EventoModel eModel : models){
            system.debug('EVENTOMODEL::::::'+eModel);
           
            mapIdPaciente.put(eModel.id_patient, eModel);
            profesionalesIds.add(eModel.id_staff);
          //  mapIdTutor.put(eModel.id_tutor, eModel);
			mapIdProfesional.put(eModel.id_staff, eModel);
            
            system.debug('PacienteList**************'+mapIdPaciente);
        	system.debug('TutorList**************SIZE'+mapIdTutor);
        	system.debug('ProfesionalesList**************'+mapIdProfesional);
            
        }
        if(!mapIdPaciente.isEmpty() && !mapIdProfesional.isEmpty()){
            Map<String, Account> mapPacReturn = searchAccounts(mapIdPaciente.keySet());          
            Map<String, Contact> mapProfReturn = searchProfesionales(profesionalesIds);
            Map<String, Account> mapTutorReturn = searchAccounts(mapIdTutor.keySet());

            for(String idPaciente : mapIdPaciente.keySet()){
                System.debug('IDSDEPACIENTE:::::'+idPaciente);
                EventoHCWrappper wrapper = new EventoHCWrappper();
                EventoModel model = mapIdPaciente.get(idPaciente);
                
                string idsPaciente = '-' + idPaciente;
                 
                wrapper.evento = getEventoFromParser(model, idsPaciente);
                
                system.debug('EVENTMODEL:::::::'+wrapper.evento.Numero_de_Evento__c);
                
                wrapper.cuenta = mapPacReturn.containsKey(idPaciente)
                  ? mapPacReturn.get(idPaciente)
                  : PacienteHandler.getPaciente(model?.patient?.doc_number, model?.patient?.doc_type?.code);
                  System.debug('PACIENTE::::::::'+model?.patient?.doc_number+'typedoc:::::::::'+model?.patient?.doc_type?.code);
                
                if (wrapper.cuenta == null)
            	{
                	continue;
            	}
            
            	System.debug('CUENTAID:::::'+wrapper.cuenta?.Id);
            	
                if (wrapper.cuenta?.Id == null)
            	{
                	system.debug('Evento a insertar::::' + wrapper.cuenta.Numero_de_ID__c);
                	mapAccToInsert.put(wrapper.cuenta.Numero_de_ID__c, wrapper.cuenta);
            	}                
                /*
                if(String.isBlank(String.valueOf(wrapper?.cuenta?.Id))){
                    mapAccToInsert.put(wrapper?.cuenta?.Numero_de_ID__c, wrapper?.cuenta);
                    System.debug('wrapper?.cuenta?.LastName'+ wrapper.cuenta.LastName);
                }*/                
                
                wrapper.profesional = mapProfReturn.containsKey(model.id_staff)
                  ? mapProfReturn.get(model.id_staff)
                  : null;
                
                    //: ProfesionalesHandler.getProfesional(model.id_staff, model.staff?.doc_type?.code);

                if (wrapper.profesional?.Id == null && wrapper.profesional.Numero_de_ID__c != null){
                	mapContToInsert.put(wrapper?.profesional?.Numero_de_ID__c, wrapper?.profesional);
                    System.debug('WRAPPERPROFESIONALES'+wrapper.profesional);
                    System.debug('MAPPROFESIONALES'+mapContToInsert);
                    String.isBlank(String.valueOf(wrapper.profesional.Numero_de_ID__c));
                }
                
            /*    wrapper.Tutor = mapTutorReturn.containsKey(model.tutor?.id_tutor)
                   ? mapTutorReturn.get(model.tutor?.id_tutor)
                   : TutorHandler.getTutor(model.tutor?.doc, model.tutor?.tdoc?.code)[0];
                if(String.isBlank(String.valueOf(wrapper?.tutor?.Id))){
                    mapTutorToInsert.put(wrapper?.tutor?.Numero_de_ID__c, wrapper?.tutor);
                  }
			*/
                List<EventoModel.Diagnostico> listDiagnostico = model.diagnostics;
                if (listDiagnostico != null) {
                    for (EventoModel.Diagnostico diagnostico : listDiagnostico) {
                        wrapper?.codigosDeDiagnostico?.add(diagnostico?.code);
                    }
                }

                listWrapper.add(wrapper);
                system.debug('LISTWRAPPER:::::'+listWrapper);
            }
        }
        //createWrapperEventoHCApp(listWrapper, mapIdPaciente, mapContToInsert.values()); //mapTutorToInsert.values());
   		
       List<HealthCloudGA__EHRProcedure__c> newEventHC = createWrapperEventoHCApp(listWrapper, mapAccToInsert.values(), mapContToInsert.values());// mapTutorToInsert.values()); //);
       
		          
       insert newEventHC;
       System.debug('***********NEWEVENTINSERT'+newEventHC);
       
   	}
    public static List<HealthCloudGA__EHRProcedure__c> createWrapperEventoHCApp(List<EventoHCWrappper> listWrapper, List<Account> listAccToInsert, List<Contact> listContToInsert){// List<Account> listTutorToInsert){
        List<HealthCloudGA__EHRProcedure__c> listEventoHCToUpsert = new List<HealthCloudGA__EHRProcedure__c>();
        System.debug('LISTADODECUENTAS:::::::'+listAccToInsert);
        System.debug('LISTADODEEVENTOS:::::::'+listWrapper);
        if(!listWrapper.isEmpty()){
            try{
                if(!listAccToInsert.isEmpty()) {           		
                    upsert listAccToInsert Id_Paciente__c;				                 
                	system.debug('UPSERTPACIENTE::::' + listAccToInsert);
                }
                if(!listContToInsert.isEmpty() ){
                    upsert listContToInsert Numero_de_ID__c;   
                    system.debug('UPSERTPROFESIONAL::::' + listContToInsert);
                }
                /*    if(!listTutorToInsert.isEmpty()){
                        upsert listTutorToInsert Id_Tutor__c;
                        system.debug('UPSERTTUTOR::::' + listContToInsert);
                    }*/                    
                 
                
                for (EventoHCWrappper wrapper: listWrapper) {
                    
                    if (!listAccToInsert.isEmpty() && wrapper.evento.HealthCloudGA__Account__c == null) { 
                        
                        for(Account ac: listAccToInsert){
                            System.debug('WRAPPERACCOUNT::::::::'+wrapper.cuenta);                                                        
                        	System.debug('***********cuenta:'+ac);
                        	System.debug('***********cuentaid:'+ac);
                            System.debug('********wrappercuentaid:'+wrapper.cuenta.Id_Paciente__c);

                            if(ac.Id_Paciente__c == wrapper.cuenta.Id_Paciente__c){
                                wrapper.evento.HealthCloudGA__Account__c = ac.id;
                                system.debug('ACCOUNTSID:::'+ac.id);
                            }
                        }
                    }
                    else{
                        wrapper.evento.HealthCloudGA__Account__c = wrapper?.cuenta?.Id;
                    }
                }
                
                
                Map<String,  ID> diagnosticosIdByCode = getDiagnosticosIDByCode(codigosDiagnosticos(listWrapper));
                List<Diagnostico_de_paciente__c> listDiagnosticoPat = new List<Diagnostico_de_paciente__c>();
                for(EventoHCWrappper wrapper: listWrapper){
                    
                    wrapper.evento.HealthCloudGA__Account__c = wrapper?.cuenta?.Id;
                    wrapper.evento.Nombre_Profesional__c = wrapper.profesional != null ? wrapper.profesional.Id : null;
                  //  wrapper.evento.Acompanante_o_Responsable__c = wrapper?.tutor.Id;
					system.debug('WRAPPERCUENTA:::::::::'+wrapper.evento.HealthCloudGA__Account__c);
                    system.debug('WRAPPERPROFESIONAL:::::::::'+wrapper.evento.Nombre_Profesional__c);
                   // system.debug('WRAPPERTUTOR:::::::::'+wrapper.tutor.Id);
                    
                    if (wrapper?.codigosDeDiagnostico != null && !wrapper?.codigosDeDiagnostico.isEmpty()) {
                        for (String codigo : wrapper.codigosDeDiagnostico) {
                            listDiagnosticoPat.add(new Diagnostico_de_paciente__c(
                            Paciente__c = wrapper.evento.HealthCloudGA__Account__c,
                            Diagnostico__c = diagnosticosIdByCode.get(codigo)));					
                        }
                    }

                    listEventoHCToUpsert.add(wrapper.evento);
                    system.debug('LISTAEVENTOSUPSERT:::::::'+listEventoHCToUpsert);
                }
                insert listDiagnosticoPat;
                System.debug('INSERTLISTADEDIAGNOSTICOS::::::'+listDiagnosticoPat);
                
            }catch(DmlException ex){
                System.debug('Error: ' + ex.getMessage());
            }
        
            System.debug('EventoInsert:::::::'+listEventoHCToUpsert);

    	}
        return listEventoHCToUpsert;

    }
    private static  set<String> codigosDiagnosticos(List<EventoHCWrappper> listEventoHCWrappper){
        Set<String> result = new Set<String>();
        for(EventoHCWrappper eventoHCWrappers : listEventoHCWrappper){
            if (eventoHCWrappers.codigosDeDiagnostico != null && !eventoHCWrappers.codigosDeDiagnostico.isEmpty()) {
                result.addAll(eventoHCWrappers.codigosDeDiagnostico);
            }

        }
        return result;
    }
    public static Map<String, Id> getDiagnosticosIDByCode(set<String> codigosDiagnosticos){
        Map<String, Id> resultado = new Map<String, Id>();
        List<HealthCareDiagnosis> listDiagnostico = [SELECT Id, Codigo_Diagnostico__c FROM HealthCareDiagnosis WHERE Codigo_Diagnostico__c  IN : codigosDiagnosticos];
        for(HealthCareDiagnosis diagnostico : listDiagnostico ){
            resultado.put(diagnostico.Codigo_Diagnostico__c, diagnostico.Id);
        }
        return resultado;
    }
    public static Map<String, Account> searchAccounts(Set<String> idsSet){
        Map<String, Account> mapPacReturn = new Map<String, Account>();
        List<Account> listPac = [SELECT Id, Id_Paciente__c FROM Account WHERE Id_Paciente__c  IN : idsSet FOR UPDATE];
        for(Account acc : listPac){
            mapPacReturn.put(acc.Id_Paciente__c, acc);
        }
        return mapPacReturn;
    }
    public static Map<String, Contact> searchProfesionales(Set<String> idsSet){
        Map<String, Contact> mapProfReturn = new Map<String, Contact>();
        List<Contact> listProf = [SELECT Id, Numero_de_ID__c FROM Contact WHERE Numero_de_ID__c IN : idsSet];
        for(Contact con : listProf){
            mapProfReturn.put(con.Numero_de_ID__c, con);
        }
        return mapProfReturn;
    }
	public static HealthCloudGA__EHRProcedure__c getEventoFromParser(EventoModel model, string idPatient){
        List<String> starDate = String.valueOf(model.start_date).split('/');
        List<String> starHour = String.valueOf(model.start_hour).split(':');
     	system.debug('**********NEWEVENT'+model);
        return new HealthCloudGA__EHRProcedure__c(
            Alergias_del_paciente__c = String.valueOf(model.allergies),
            Alertas_del_paciente__c =  String.valueOf(model.alerts),
            Motivo_de_la_consulta__c = String.valueOf(model.reason),
            Incapacidades__c = String.valueOf(model.inability),
            Valor_facturado_paciente__c = model.patient_invoiced_value != null ? decimal.valueOf(model.patient_invoiced_value) : null,
            Valor_facturado_convenio__c = model.insurance_invoiced_value != null ? decimal.valueOf(model.insurance_invoiced_value) : null,
            Indicaciones__c = String.valueOf(model.indications),
            Ordenes_medicas__c = String.valueOf(model.prescription),
            Fecha_hora_del_evento__c = Datetime.newInstance(Integer.valueOf(starDate[0]),Integer.valueOf(starDate[1]),Integer.valueOf(starDate[2]),Integer.valueOf(starHour[0]),Integer.valueOf(starHour[1]),0),
//            Numero_de_Evento__c = model.event_number != null ? decimal.valueOf(model.event_number + idPatient) : null, //!= null ?  decimal.valueOf(model.event_number) : null,
            Number_event__c = model.event_number != null ? model.event_number + idPatient : null, //!= null ?  decimal.valueOf(model.event_number) : null,
            Tipo_de_Evento_Ambito__c = model.ambit.detail,
            Antecedentes_del_paciente__c = String.valueOf(model.records),
            Examen_fisico_general__c = String.valueOf(model.physical_exam),
            Evoluciones__c = String.valueOf(model.progress)
        );
    }

    public class EventoHCWrappper{
        Account cuenta;
        Account tutor;
        Contact profesional;
        HealthCloudGA__EHRProcedure__c evento;
        Set<String> codigosDeDiagnostico;
    }

    
    
}