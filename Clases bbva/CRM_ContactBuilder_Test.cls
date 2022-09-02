@IsTest
public with sharing class CRM_ContactBuilder_Test {

    @IsTest
    static void builderTest(){
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Test.startTest();
            Contact cnt = new CRM_ContactBuilder().documentNumber('36562545')
                                                .documentType('DNI')
                                                .firstName('Test')
                                                .lastName('User')
                                                .email('test-user@bbva.com.ar')
                                                .phone('123456')
                                                .build();
            System.assertNotEquals(null, cnt, 'Contact should not be null');
            Test.stopTest();
        }
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
