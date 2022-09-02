/**
* @author BBVA Salesforce Team
* @date 2021
*/
@isTest
public with sharing class CRM_SCC_DNIRequest_Test {

    /**
      * @description Test for dni requested process within Social Service
    */
    @isTest static void shouldSetDniRequested() {
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Account acc = new Account(Name = 'Test Account');
            insert acc;

            SocialPersona spersona = new SocialPersona(
                Name = 'Social Person Test',
                ParentId = acc.Id,
                Provider = 'Facebook'
            );
            insert spersona;

            SocialPost sp = new SocialPost(name='Social Post Test', PersonaId = spersona.Id, IsOutbound=true);
            insert sp;

            Test.startTest();
            CRM_SCC_DNIRequest.Request request = new CRM_SCC_DNIRequest.Request();
            request.socialPostRecord = sp;
            CRM_SCC_DNIRequest.markDniAsRequested(new List<CRM_SCC_DNIRequest.Request>{request});
            spersona = [SELECT Id, CRM_SCC_DNIRequested__c FROM SocialPersona WHERE Id = :spersona.Id];
            System.assertEquals(true, spersona.CRM_SCC_DNIRequested__c, 'The DNI request should be shown as true');
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