/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-26-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class PublicFormServiceTest {
    @isTest
    static void testPublicFormServiceTest(){
 	    
        String jsonResponse = '{ "id":"ES348234988742C","name":"Jonh","lastName":"Erick","secondLastName":"Vargas","birthData":{"birthDate":"1985-10-02"},"identityDocument":{"documentType":{"id":"NIF"},"documentNumber":"12128494P"},"contactDetail":{"contact":{"contactDetailType":"LANDLINE","number":"916665432" }}}';
        AccountModel model;    
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
        
        model = AccountModel.getResults(jsonResponse);
        PublicFormService.publicFormServiceOfClient(caseTest.id,model);              
    }
}