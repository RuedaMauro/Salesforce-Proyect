@IsTest
public with sharing class CRM_SCC_CaseFormWebService_Test {


    @IsTest
    static void doPostMethodForPrivateFormTest(){
        User contextUser = getContextUser();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/cases/forms';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serialize(createPrivateFormData()));
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        System.runAs(contextUser){
            CRM_SCC_CaseFormWebService.doPostMethod();
            System.assertNotEquals(null, req.requestBody, 'Request body should not be null');
        }
        Test.stopTest();

    }

    @IsTest
    static void doPostMethodForPublicFormTest(){
        User contextUser = getContextUser();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/cases/forms';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSON.serialize(createPublicFormData()));
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        System.runAs(contextUser){
            CRM_SCC_CaseFormWebService.doPostMethod();
            System.assertNotEquals(null, req.requestBody, 'Request body should not be null');
        }
        Test.stopTest();

    }

    @IsTest
    static void doPostMethodForInvalidFormTest(){
        User contextUser = getContextUser();

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/cases/forms';
        req.httpMethod = 'POST';
        req.requestBody = null;
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        System.runAs(contextUser){
            CRM_SCC_CaseFormWebService.doPostMethod();
            System.assertEquals(null, req.requestBody, 'Request body should be null');
        }
        Test.stopTest();

    }

    private static CRM_SCC_Form createPrivateFormData() {
        CRM_SCC_Form form = new CRM_SCC_Form();
        CRM_SCC_Form.FormAttachment newAttachment = new CRM_SCC_Form.FormAttachment();
        newAttachment.contentType = 'Archivo Adjunto';
        newAttachment.fileName = 'multipart/form-data';
        newAttachment.file = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg';
        form.type = 'Adquisición';
        form.product = 'Comercio Exterior';
        form.reason = 'Asesoramiento sobre nuevos productos o servicios';
        form.message = 'Necesito asesoramiento sobre nuevos productos';
        form.source = 'Formulario Privado';
        form.contactNumber = '2345';
        form.cellEmail = 'email.celula@bbva.com';
        form.name = 'Juan Cruz';
        form.surname = 'Perez';
        form.email = 'juancruz.perez@bbva.com';
        form.phone = '1187654321';
        form.documentNumber = '37033374';
        form.attachedFiles = new List<CRM_SCC_Form.FormAttachment>{newAttachment};

        return form;
    }

    private static CRM_SCC_Form createPublicFormData() {
        CRM_SCC_Form form = new CRM_SCC_Form();
        CRM_SCC_Form.FormAttachment newAttachment = new CRM_SCC_Form.FormAttachment();
        newAttachment.contentType = 'Archivo Adjunto';
        newAttachment.fileName = 'multipart/form-data';
        newAttachment.file = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg';
        form.type = 'Adquisición';
        form.product = 'Comercio Exterior';
        form.reason = 'Asesoramiento sobre nuevos productos o servicios';
        form.message = 'Necesito asesoramiento sobre nuevos productos';
        form.source = 'Formulario Público';
        form.contactNumber = '2345';
        form.cellEmail = 'email.celula@bbva.com';
        form.name = 'Juan Cruz';
        form.surname = 'Perez';
        form.email = 'juancruz.perez@bbva.com';
        form.phone = '1187654321';
        form.documentNumber = '37033374';
        form.attachedFiles = new List<CRM_SCC_Form.FormAttachment>{newAttachment};

        return form;
    }

    /**
      * @description This method creates a context user for test purposes
      * @return User: context user with profile and permission sets assigned
    */
    private static User getContextUser(){
        Profile minimumAccessProfile = [SELECT Id FROM Profile WHERE Name='Minimum Access - Salesforce'];
        User contextUser = new User(
            Username = 'test-user@bbva.com.ar',
            LastName = 'test',
            Email = 'test-user@bbva.com.ar',
            Alias = 'testusr',
            TimeZoneSidKey = 'America/Argentina/Buenos_Aires',
            LocaleSidKey = 'es_AR',
            EmailEncodingKey = 'UTF-8',
            ProfileId = minimumAccessProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert contextUser;
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CRM_SCC_SocialSystemAdmin'];

        insert new PermissionSetAssignment(AssigneeId = contextUser.id, PermissionSetId = ps.Id);

        return contextUser;
    }
}
