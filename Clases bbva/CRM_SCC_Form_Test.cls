@IsTest
public with sharing class CRM_SCC_Form_Test {
    @IsTest
    static void methodName(){
        User contextUser = getContextUser();
        Test.startTest();
        System.runAs(contextUser){
            CRM_SCC_Form form = new CRM_SCC_Form();
            form.type = 'Adquisición';
            form.product = 'Comercio Exterior';
            form.reason = 'Asesoramiento sobre nuevos productos o servicios';
            form.message = 'Necesito asesoramiento sobre nuevos productos';
            form.source = 'Formulario Público';
            form.contactNumber = '2345';
            form.cellEmail = 'email.celula@bbva.com';
            form.name = 'Juan Cruz';
            form.surname = 'Soldavila';
            form.email = 'juancruz.soldavila@gmail.com';
            form.phone = '11-8765-4321';
            form.documentNumber = '37033374';
            Boolean isValid = form.isValid();
            System.debug('Valid: ' + isValid);
            System.assertEquals(true, isValid, 'Form should be valid');
        }
        Test.stopTest();
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
