/**
* @author BBVA Salesforce Team
* @date 2021
*/
@isTest
public with sharing class CRM_SCC_MilestoneCompletionSocial_Test {
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
            CRM_SCC_MilestoneCompletionSocial.Request request = new CRM_SCC_MilestoneCompletionSocial.Request();
            request.sourceCase = cs.Id;
            request.milestoneName = 'Primera respuesta al cliente';
            CRM_SCC_MilestoneCompletionSocial.milestoneCompletion(new List<CRM_SCC_MilestoneCompletionSocial.Request>{request});
            System.assertNotEquals(null, request, 'Request should not be null');
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
