public with sharing class CRM_CaseBuilder {
    private Case builtCase;

    public CRM_CaseBuilder(){
        this.builtCase = new Case();
    }

    public CRM_CaseBuilder recordType(String developerName){
        try {
            RecordType caseRecordtype = [SELECT Id FROM RecordType WHERE DeveloperName = :developerName WITH SECURITY_ENFORCED LIMIT 1];
            this.builtCase.RecordTypeId = caseRecordtype.Id;
        } catch (QueryException e) {
            System.debug('Query exception: ' + e.getMessage());
        }
        return this;
    }

    public CRM_CaseBuilder subject(String subject){
        builtCase.Subject = subject;
        return this;
    }

    public CRM_CaseBuilder type(String type){
        builtCase.Type = type;
        return this;
    }

    public CRM_CaseBuilder product(String product){
        builtCase.CRM_SCC_ProductAndService__c = product;
        return this;
    }

    public CRM_CaseBuilder reason(String reason){
        builtCase.CRM_SCC_ContactReason__c = reason;
        return this;
    }

    public CRM_CaseBuilder source(String source){
        builtCase.Origin = source;
        return this;
    }

    public CRM_CaseBuilder cellEmail(String cellEmail){
        builtCase.CRM_SCC_SelectedEmail__c = cellEmail;
        return this;
    }

    public CRM_CaseBuilder attentionHour(String attentionHour){
        builtCase.CRM_SCC_Horario__c = attentionHour;
        return this;
    }

    public CRM_CaseBuilder contactNumber(String contactNumber){
        builtCase.CRM_SCC_NroContacto__c = contactNumber;
        return this;
    }

    public CRM_CaseBuilder clientType(String clientType){
        builtCase.CRM_SCC_CustomerSegment__c = clientType;
        return this;
    }

    public CRM_CaseBuilder description(String description){
        builtCase.Description = description;
        return this;
    }

    public CRM_CaseBuilder accountId(String accountId){
        builtCase.AccountId = accountId;
        return this;
    }

    public CRM_CaseBuilder contactId(String contactId){
        builtCase.ContactId = contactId;
        return this;
    }

    public Case build(){
        return this.builtCase;
    }
}