public with sharing class SiteSearchPatients {
 @AuraEnabled
    public static List<Account> getPatients(String keySearch){
        List<Account> patients = [SELECT FirstName, LastName FROM Account WHERE Numero_de_ID__c=:keySearch];
        return patients;
    }
}