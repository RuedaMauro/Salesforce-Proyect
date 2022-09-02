@SuppressWarnings('pmd')
public with sharing class CRM_SCC_Form {
    public String type { get; set;} // -> Type
    public String product { get; set;} //-> CRM_SCC_ProductAndService__c
    public String reason { get; set;} //-> CRM_SCC_ContactReason__c
    public String message { get; set;} //-> Description
    public String source { get; set;} //-> Origin (Publico o privado)
    public String contactNumber { get; set;} //-> CRM_SCC_NroContacto__c
    public String cellEmail { get; set;} //-> CRM_SCC_SelectedEmail__c

    public String name { get; set;} //-> FirstName
    public String surname { get; set;} //-> LastName
    public String email { get; set;} //-> PersonEmail
    public String phone { get; set;} //-> Phone
    public String documentNumber { get; set;} //-> CRM_SCC_DocumentNumber__c
    public String documentType { get; set;} //-> CRM_SCC_DocumentType__c

    public String clientType { get; set;} // -> CRM_SCC_CustomerSegment__c
    public String attentionHour { get; set;} //-> CRM_SCC_Horario__c
    public String clientId { get; set;} //Account.AccountNumber
    public List<FormAttachment> attachedFiles { get; set;}

    public class FormAttachment {
        public String fileName { get; set;}
        public String contentType { get; set;}
        public String file { get; set;} //base64 encoded format
    }

    public Boolean isValid(){
        Boolean isValid = String.isNotEmpty(this.type) &&
                        String.isNotEmpty(this.product) &&
                        String.isNotEmpty(this.reason) &&
                        String.isNotEmpty(this.message) &&
                        String.isNotEmpty(this.source) &&
                        String.isNotEmpty(this.contactNumber) &&
                        String.isNotEmpty(this.cellEmail) &&
                        String.isNotEmpty(this.name) &&
                        String.isNotEmpty(this.surname) &&
                        String.isNotEmpty(this.email) &&
                        String.isNotEmpty(this.phone) &&
                        String.isNotEmpty(this.documentNumber);

        return isValid;
    }
}