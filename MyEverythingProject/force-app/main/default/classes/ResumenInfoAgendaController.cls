public with sharing class ResumenInfoAgendaController {
    @AuraEnabled(cacheable=true)
    public static List<ServiceAppointment> getAgenda(Id patientId){
        try {
            return [SELECT Id, Status, Fecha_y_Hora_agenda__c,SchedStartTime FROM ServiceAppointment WHERE AccountId =: patientId  ORDER BY Fecha_y_Hora_agenda__c DESC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}