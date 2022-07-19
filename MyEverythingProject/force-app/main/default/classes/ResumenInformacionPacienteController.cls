public with sharing class ResumenInformacionPacienteController {

    @AuraEnabled(cacheable=true)
    public static Diagnostico_de_paciente__c getDiagnosticosDelPaciente(Id patientId){
        try {
            return [SELECT Id, Name, Nombre_Diagnostico__c FROM Diagnostico_de_paciente__c WHERE Paciente__c =: patientId  ORDER BY createdDate DESC LIMIT 1][0];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<HealthCloudGA__EHRProcedure__c> getEventosDeLaHistoriaClinica(Id patientId){
        try {
            return [SELECT Id, Name, Tipo_de_Evento_Ambito__c, Fecha_hora_del_evento__c FROM HealthCloudGA__EHRProcedure__c WHERE HealthCloudGA__Account__c =: patientId ORDER BY Fecha_hora_del_evento__c ASC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<ServiceAppointment> getAgenda(Id patientId){
        try {
            return [SELECT Id, Status, Fecha_y_Hora_agenda__c,SchedStartTime FROM ServiceAppointment WHERE AccountId =: patientId  ORDER BY Fecha_y_Hora_agenda__c DESC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static HealthCloudGA__EHRProcedure__c getEventoHC(Id patientId){
        try {
            return [SELECT Id, Name, Tipo_de_Evento_Ambito__c, Fecha_hora_del_evento__c,NPS_evento__c, CSAT_evento__c FROM HealthCloudGA__EHRProcedure__c WHERE HealthCloudGA__Account__c =: patientId AND Tipo_de_Evento_Ambito__c <> NULL ORDER BY Fecha_hora_del_evento__c ASC LIMIT 1];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static String getAcompanante(Id patientId){
        try {
            AccountContactRelation accountContR = [SELECT contact.account.Name FROM AccountContactRelation WHERE accountid =: patientId AND contact.account.recordType.DeveloperName = 'Acompanante' LIMIT 1];            
            return accountContR != null ? accountContR.contact.account.Name : '';
            //return [SELECT Id, Name FROM Contact WHERE Nombre_del_paciente__c =: patientId AND RecordType.DeveloperName ='Acompanante' ORDER BY createdDate DESC LIMIT 1][0];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static Convenios_de_paciente__c getConvenioDelPaciente(Id patientId){
        try {

            return [SELECT Id, Name, Nombre_de_convenio_plan__c, Clasificacion__c  FROM Convenios_de_paciente__c WHERE Paciente__c =: patientId ORDER BY createdDate DESC LIMIT 1][0];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}