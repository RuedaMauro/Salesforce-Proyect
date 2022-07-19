public with sharing class ResumenInfoEventosDeLaHistoria{
    
    @AuraEnabled(cacheable=true)
    public static List<HealthCloudGA__EHRProcedure__c> getEventosDeLaHistoriaClinica(Id patientId){
        try {
            return [SELECT Id, Name, Tipo_de_Evento_Ambito__c, Fecha_hora_del_evento__c FROM HealthCloudGA__EHRProcedure__c WHERE HealthCloudGA__Account__c =: patientId AND Tipo_de_Evento_Ambito__c <> NULL ORDER BY Fecha_hora_del_evento__c ASC LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}