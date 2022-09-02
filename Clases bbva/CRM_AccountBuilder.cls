public with sharing class CRM_AccountBuilder {
    private Account builtAccount;

    public CRM_AccountBuilder() {
        this.builtAccount = new Account();
    }

    public CRM_AccountBuilder recordType(String developerName){
        try {
            RecordType accountRecordtype = [SELECT Id FROM RecordType WHERE DeveloperName = :developerName WITH SECURITY_ENFORCED LIMIT 1];
            this.builtAccount.RecordTypeId = accountRecordtype.Id;
        } catch (QueryException e) {
            System.debug('Query exception: ' + e.getMessage());
        }
        return this;
    }

    public CRM_AccountBuilder firstName(String firstName){
        builtAccount.FirstName = firstName;
        return this;
    }

    public CRM_AccountBuilder lastName(String lastName){
        builtAccount.LastName = lastName;
        return this;
    }

    public CRM_AccountBuilder documentNumber(String documentNumber){
        builtAccount.CRM_SCC_DocumentNumber__c = documentNumber;
        return this;
    }

    public CRM_AccountBuilder documentType(String documentType){
        builtAccount.CRM_SCC_DocumentType__c = documentType;
        return this;
    }

    public CRM_AccountBuilder personEmail(String personEmail){
        builtAccount.PersonEmail = personEmail;
        return this;
    }

    public CRM_AccountBuilder phone(String phone){
        builtAccount.Phone = phone;
        return this;
    }

    public CRM_AccountBuilder accountNumber(String accountNumber){
        builtAccount.AccountNumber = accountNumber;
        return this;
    }

    public Account build(){
        return this.builtAccount;
    }
}