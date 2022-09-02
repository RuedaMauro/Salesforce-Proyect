/**
* @author BBVA Salesforce Team
* @date 2021
*/
@IsTest
public with sharing class CRM_CaseTriggerHandler_Test {

    /**
      * @description This method tests the entitlement assignment for cases
    */
    @isTest
    static void assingEntitlementTest() {
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Account a = new Account(Name='Test Account');
            insert a;

            Entitlement e = new Entitlement(Name='SocialCustomerCare', AccountId=a.Id);
            insert e;

            Test.startTest();
            Case c = new Case();
            c.AccountId = a.Id;
            c.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CRM_Cas_ParentCase' WITH SECURITY_ENFORCED LIMIT 1].Id;
            insert c;
            Test.stopTest();
            c = [SELECT Id FROM Case WHERE Account.Name = 'Test Account' LIMIT 1];
            System.assertNotEquals(null, c, 'Case should be inserted correctly');
        }
    }

    @isTest
    static void assingChildEntitlementTest() {
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Account a = new Account(Name='Test Account');
            insert a;

            Entitlement e = new Entitlement(Name='Seguros', AccountId=a.Id);
            insert e;

            Test.startTest();
            Case c = new Case();
            c.AccountId = a.Id;
            c.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CRM_Cas_ChildCase' WITH SECURITY_ENFORCED LIMIT 1].Id;
            c.CRM_SCC_Management__c = 'Seguros';
            insert c;
            Test.stopTest();
            c = [SELECT Id FROM Case WHERE Account.Name = 'Test Account' LIMIT 1];
            System.assertNotEquals(null, c, 'Case should be inserted correctly');
        }
    }

    /**
      * @description This method tests the activation of assignment rules for cases
    */
    @IsTest
    static void activateAssignmentRules(){
        User contextUser = getContextUser();
        System.runAs(contextUser){
            Account a = new Account(Name='Test Account');
            insert a;
            Test.startTest();
            Case c = new Case();
            c.AccountId = a.Id;
            c.RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CRM_Cas_ChildCase' WITH SECURITY_ENFORCED LIMIT 1].Id;
            insert c;
            Test.stopTest();

            c = [SELECT Id FROM Case WHERE Account.Name = 'Test Account' LIMIT 1];
            System.assertNotEquals(null, c, 'Case should be inserted correctly');
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
