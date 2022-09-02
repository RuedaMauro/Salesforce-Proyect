/**
* @author BBVA Salesforce Team
* @date 2021
*/
@isTest
public with sharing class CRM_SocialPostTriggerHandler_Test {

    /**
      * @description Test the first response handler for Social Posts
    */
    @IsTest
    static void handleFirstResponseTest(){
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Account a = new Account(Name='Test Account');
            insert a;
            Contact c = new Contact(AccountId = a.Id, Email='test@example.com', LastName='Test');
            insert c;
            Entitlement e = new Entitlement(Name='SocialCustomerCare', AccountId=a.Id);
            insert e;
            Case cs = new Case(ContactId = c.Id, AccountId = a.Id, EntitlementId=e.Id, SlaStartDate=System.now());
            insert cs;

            Test.startTest();
            SocialPost sp = new SocialPost();
            sp.Name='Test post';
            sp.ParentId = [SELECT Id FROM Case WHERE Account.Name = 'Test Account' LIMIT 1].Id;
            insert sp;
            Test.stopTest();
            System.assertNotEquals(null, sp.Id, 'Social Post should insert correctly');
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
