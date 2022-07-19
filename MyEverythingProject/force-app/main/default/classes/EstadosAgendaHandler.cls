public with sharing class EstadosAgendaHandler{

    public static final String NAMED_CREDENTIAL = 'callout:Name_Credential_Deshc';

    public static void makePostCallout(List<ServiceAppointment> listServiceA) {
        Map<Id,contact> acompanantes = AcompanantesPorIdPaciente(listServiceA);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(NAMED_CREDENTIAL + '/agenda/status');
        request.setMethod('PUT');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');        
        List<String> objects = new List<String>();
        List<ServiceAppointment> serviceAppToUpdate = new List<ServiceAppointment>();
        for(ServiceAppointment serApp : listServiceA){
            System.debug('autorizaciones*******'+serApp.Autorizaciones__r);
            Autorizacion__c ultimaAutorizacion = serApp.Autorizaciones__r.isEmpty() ? null : serApp.Autorizaciones__r[0];
            system.debug('ultimaAutorizacion.Estado_de_la_autorizacion__c'+ultimaAutorizacion.Estado_de_la_autorizacion__c);
            system.debug(' serApp.Reenvio_de_datos__c'+ serApp.Reenvio_de_datos__c);

            if(ultimaAutorizacion.Estado_de_la_autorizacion__c != 'Autorizado'){
                serApp.Reenvio_de_datos__c = 2; 
                
                objects.add(buildSingleNode(serApp, acompanantes));
                serviceAppToUpdate.add(serApp);

            }else if(serApp.Reenvio_de_datos__c != 3){
                serApp.Reenvio_de_datos__c = 3;
                objects.add(buildSingleNode(serApp, acompanantes));
                serviceAppToUpdate.add(serApp);

            }     
            system.debug('serApp.Reenvio_de_datos__c'+ serApp.Reenvio_de_datos__c);
            
        }            
        
        
        String bodyRequest ='['+ String.join(objects,',') + ']';

        System.debug('bodyInternalRequestFINAL'+bodyRequest);
        request.setBody(bodyRequest);
        HttpResponse response = http.send(request);
        if(!serviceAppToUpdate.isEmpty()){            
            update serviceAppToUpdate; 
        } 
        for(ServiceAppointment serviApp: serviceAppToUpdate){
            system.debug('serviAppupdate'+ serviApp);
        }        
		if(response.getStatusCode() != 201) {
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }
    }    

    private static Map<Id,contact> AcompanantesPorIdPaciente(List<ServiceAppointment> listServiceA){
        Set<id> idPacientes = new Set<id>();
        for(ServiceAppointment serviceApp : listServiceA){
            idPacientes.add(serviceApp.AccountId);
            
        }
        Map<Id,contact> result= new Map<Id,Contact>();
        List<AccountContactRelation> accContRelation = [SELECT AccountId,ContactId, contact.account.recordType.DeveloperName, contact.Tipo_de_Id__c, contact.account.PersonEmail, contact.account.PersonMobilePhone, contact.Numero_de_ID__c, contact.account.Name FROM AccountContactRelation WHERE accountid IN : idPacientes AND contact.account.recordType.DeveloperName = 'Acompanante'];
        for(AccountContactRelation accContR :accContRelation){
            result.put(accContR.AccountId, accContR.Contact);            
        }
        return result;
    }

	private static String buildSingleNode(ServiceAppointment serApp, Map<Id,contact> AcompanantesPorIdPaciente) {
        contact acompanante = AcompanantesPorIdPaciente.get(serApp.AccountId);
		Map<String, Object> jsonNode = new Map<String, Object>();
		jsonNode.put('form_number', serApp.Id_Agenda__c);
        jsonNode.put('status_code', serApp.Status);
        jsonNode.put('attention_cost', serApp.Valor_de_Servicio__c);
		jsonNode.put('tutor_name', acompanante?.Account.name);
        jsonNode.put('tutor_doc', acompanante?.Numero_de_ID__c);
        jsonNode.put('tutor_tdoc', acompanante?.Tipo_de_Id__c);
        jsonNode.put('tutor_phone', acompanante?.Account.PersonMobilePhone);
        jsonNode.put('tutor_email', acompanante?.Account.PersonEmail);
        Autorizacion__c ultimaAutorizacion = serApp.Autorizaciones__r.isEmpty() ? null : serApp.Autorizaciones__r[0];
        jsonNode.put('Auth_code', ultimaAutorizacion?.Numero_de_autorizacion__c);
        jsonNode.put('auth_user', ultimaAutorizacion?.Persona_aprobadora__c);
		jsonNode.put('insurance_code', ultimaAutorizacion?.Codigo_de_Convenio_plan__c);	
        jsonNode.put('insurance_cost', ultimaAutorizacion?.Costo_convenio__c);
        jsonNode.put('patient_cost', ultimaAutorizacion?.Costo_Paciente__c);
        jsonNode.put('auth_date', ultimaAutorizacion?.Fecha_de_autorizacion__c);
        jsonNode.put('auth_duedate', ultimaAutorizacion?.Fecha_de_vencimiento_de_la_autorizacion__c);				
		return JSON.serialize(jsonNode); 
	} 
}