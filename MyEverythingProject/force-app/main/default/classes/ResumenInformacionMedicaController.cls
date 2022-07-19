public with sharing class ResumenInformacionMedicaController {
    @AuraEnabled(cacheable=true)
    public static ClinicalEncounterDiagnosis getDiagnosticosDelPaciente(Id patientId){
        try {

            return [SELECT Id, Name FROM ClinicalEncounterDiagnosis WHERE Paciente__c =: patientId  ORDER BY createdDate DESC LIMIT 1][0];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}