/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-26-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class PrivateFormServiceTest {
     @isTest
     static void testPrivateFormServiceTest(){
 	    
        AccountModel model;    
        Account accountIfExisting;
        String jsonResponse = '{ "id":"ES348234988742C","name":"Jonh","lastName":"Erick","secondLastName":"Vargas","birthData":{"birthDate":"1985-10-02"},"identityDocument":{"documentType":{"id":"NIF"},"documentNumber":"12128494P"},"contactDetail":{"contact":{"contactDetailType":"LANDLINE","number":"916665432" }}}';
        String nameClient;
         
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        
         
         Account acc = new Account(
            RecordTypeId = accRecTypeId,
            FirstName = 'Jonh Erick',
            LastName = 'Vargas', 
            CRM_SCC_DocumentNumber__c = '12128494P'            
         );
         insert acc;
		
         Case caseTest = new Case(
       	    Origin = 'Formulario Privado',
            AccountId = acc.id
         );
         insert caseTest;
        
        nameClient = acc.FirstName + acc.LastName;
         
        
         Test.startTest();
         model = AccountModel.getResults(jsonResponse);
         accountIfExisting = AccountModel.getAccountFromParser(model);
         PrivateFormService.privateFormServiceOfClient(caseTest.id,model);
         Test.stopTest();
         
     }
}