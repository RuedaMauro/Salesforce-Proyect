@IsTest
public with sharing class CRM_CaseHierarchyController_Test {

    @TestSetup
    static void makeData(){
        Case parent = new Case(
            Status = 'Derivado',
            CRM_SCC_ProductAndService__c = 'Sucursales',
            CRM_SCC_ContactReason__c = 'Turnos',
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CRM_Cas_ParentCase' LIMIT 1].Id
        );
        insert parent;

        Case child = new Case(
            CRM_AreaInterna__c = 'Coordinación',
            CRM_SCC_Management__c = 'Célula de Atención',
            CRM_SCC_EntitlementStatus__c = 'Active',
            Status = 'Esperando Respuesta de Coordinacion',
            ParentId = parent.Id,
            RecordTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CRM_Cas_ChildCase' LIMIT 1].Id
        );
        insert child;
    }

    @IsTest
    static void getCaseWithChildsTest(){
        User contextUser = getContextUser();

        Test.startTest();
        System.runAs(contextUser){
            Case parent = [SELECT Id FROM Case WHERE Status = 'Derivado' LIMIT 1];

            CRM_CaseHierarchyController.HierachyResponse response = CRM_CaseHierarchyController.getCaseWithChilds(parent.Id);
            System.assertNotEquals(null, response, 'Response should not be null');
        }
        Test.stopTest();
    }

    @IsTest
    static void getParentIdIfExistsTest(){
        User contextUser = getContextUser();

        Test.startTest();
        System.runAs(contextUser){
            Case child = [SELECT Id FROM Case WHERE ParentId != null LIMIT 1];

            String parentId = CRM_CaseHierarchyController.getParentIdIfExists(child.Id);
            System.assertNotEquals(null, parentId, 'Parent Id should not be null');
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
