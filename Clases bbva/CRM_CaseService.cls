public with sharing class CRM_CaseService {

    public class FormResponse{
        public Id caseId { get; set;}
        public String status { get; set;}
        public String message { get; set;}
    }

    public static FormResponse createPrivateForm(CRM_SCC_Form data) {
        FormResponse res = new FormResponse();

        Account client = getExistingAccount(data.documentNumber, data.documentType);

        System.debug('Cuenta encontrada: ' + client);

        if(client == null){
            client = new Account(
                RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId(),
                FirstName = data.name,
                LastName = data.surname,
                CRM_SCC_DocumentType__c = 'DNI',
                CRM_SCC_DocumentNumber__c = data.documentNumber,
                PersonEmail = data.email,
                Phone= data.phone,
                AccountNumber = data.clientId
            );
        } else {
            String email1 = String.valueOf(client.PersonEmail);
            String email2 = String.valueOf(client.CRM_SCC_PersonEmail2__c);
            String email3 = String.valueOf(client.CRM_SCC_PersonEmail3__c);

            if( !email1.equals(data.email) && String.isBlank(email2)){
                client.CRM_SCC_PersonEmail2__c = data.email;
            } else if(!email1.equals(data.email) && String.isNotBlank(email2) && !email2.equals(email3)){
                client.CRM_SCC_PersonEmail3__c = data.email;
            }

            System.debug('Con emails nuevos: ' + client);
        }

        Case caseForm = new Case(
            RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('CRM_Cas_ParentCase').getRecordTypeId(),
            Subject = data.type + data.product + data.reason,
            Type = data.type,
            CRM_SCC_ProductAndService__c = data.product,
            CRM_SCC_ContactReason__c = data.reason,
            Origin = data.source,
            CRM_SCC_SelectedEmail__c = data.cellEmail,
            CRM_SCC_Horario__c = data.attentionHour,
            CRM_SCC_NroContacto__c = data.contactNumber,
            CRM_SCC_CustomerSegment__c = data.clientType,
            CRM_SCC_FirstSelectedEmail__c = data.email,
            Description = data.message,
            AccountId = client.Id
        );

        try {
            upsert client;
            insert caseForm;
            res.caseId = caseForm.Id;
            res.status = 'OK';

            if(data.attachedFiles != null){
                insertAttachments(data.attachedFiles, caseForm.Id);
            }
        } catch (DmlException dmlEx) {
            res.caseId = null;
            res.status = 'NOK';
            res.message = dmlEx.getMessage();
        }

        return res;
    }

    public static FormResponse createPublicForm(CRM_SCC_Form data) {
        FormResponse res = new FormResponse();


        Contact client = new CRM_ContactBuilder().firstName(data.name)
                                                .lastName(data.surname)
                                                .documentType('DNI')
                                                .documentNumber(data.documentNumber)
                                                .email(data.email)
                                                .phone(data.phone)
                                                .build();
        try {
            insert client;
        } catch (DmlException dmlEx) {
            res.caseId = null;
            res.status = 'NOK';
            res.message = dmlEx.getMessage();

            return res;
        }

        Case caseForm = new CRM_CaseBuilder().recordType('CRM_Cas_ParentCase')
                                            .type(data.type)
                                            .product(data.product)
                                            .reason(data.reason)
                                            .description(data.message)
                                            .source(data.source)
                                            .contactNumber(data.contactNumber)
                                            .cellEmail(data.cellEmail)
                                            .contactId(client.Id)
                                            .subject(data.type+data.product+data.reason)
                                            .build();

        try {
            insert caseForm;
            res.caseId = caseForm.Id;
            res.status = 'OK';

        } catch (DmlException dmlEx) {
            res.caseId = null;
            res.status = 'NOK';
            res.message = dmlEx.getMessage();
        }

        return res;

    }

    public static Account getExistingAccount(String documentNumber, String documentType) {
        // List<Account> searchAccount = new List<Account>();
        List<List<SObject>> searchAccount = new List<List<SObject>>();
        String auxDocumentType = documentType;

        if(String.isBlank(auxDocumentType)){
            auxDocumentType = 'DNI';
        }

        searchAccount = [FIND :documentNumber IN ALL FIELDS RETURNING Account(Id,PersonEmail, CRM_SCC_PersonEmail2__c, CRM_SCC_PersonEmail3__c WHERE CRM_SCC_DocumentNumber__c = :documentNumber AND CRM_SCC_DocumentType__c = :auxDocumentType) LIMIT 1];

        if(searchAccount[0].isEmpty()){
            return null;
        }
        return (Account) searchAccount[0][0];
    }

    public static Attachment createAttachedFile(CRM_SCC_Form.FormAttachment attachmentFile, Id parentId){
        Attachment document = new Attachment();
        document.Body = EncodingUtil.base64Decode(attachmentFile.file);
        document.Name = attachmentFile.fileName;
        document.ContentType = attachmentFile.contentType;
        document.ParentId = parentId;

        return document;
    }

    public static void insertAttachments(List<CRM_SCC_Form.FormAttachment> attachments, Id parentId){
        List<Attachment> attachmentsToInsert = new List<Attachment>();

        for(CRM_SCC_Form.FormAttachment file : attachments){
            attachmentsToInsert.add(createAttachedFile(file, parentId));
        }

        insert attachmentsToInsert;
    }
}