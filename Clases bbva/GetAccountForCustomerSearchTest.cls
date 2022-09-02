/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class GetAccountForCustomerSearchTest {
    @isTest
    static void testGetAccountForCustomerSearchTest() {

        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        
         Account acc = new Account(
            FirstName = 'Account',
            LastName = 'Test', 
            RecordTypeId = accRecTypeId,
            PersonEmail = 'test@user.com'
        );
        insert acc;
		
        Case caseTest = new Case(
       	    Origin = 'Formulario Público',
            AccountId = acc.id
        );
        insert caseTest;

        Test.startTest();
        GetAccountForCustomerSearch.getAccountForCustomerSearchClient(caseTest.id);
        Test.stopTest();
    }

}
