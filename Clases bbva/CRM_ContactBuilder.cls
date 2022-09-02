public with sharing class CRM_ContactBuilder {
    private Contact builtContact;

    public CRM_ContactBuilder() {
        this.builtContact = new Contact();

    }

    public CRM_ContactBuilder firstName(String firstName){
        builtContact.FirstName = firstName;
        return this;
    }

    public CRM_ContactBuilder lastName(String lastName){
        builtContact.LastName = lastName;
        return this;
    }

    public CRM_ContactBuilder documentType(String documentType){
        builtContact.CRM_SCC_DocumentType__c = documentType;
        return this;
    }

    public CRM_ContactBuilder documentNumber(String documentNumber){
        builtContact.CRM_SCC_DocumentNumber__c = documentNumber;
        return this;
    }

    public CRM_ContactBuilder phone(String phone){
        builtContact.Phone = phone;
        return this;
    }

    public CRM_ContactBuilder email(String email){
        builtContact.Email = email;
        return this;
    }

    public Contact build(){
        return this.builtContact;
    }
}