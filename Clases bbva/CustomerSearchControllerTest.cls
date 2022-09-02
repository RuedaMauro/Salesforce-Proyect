/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-26-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class CustomerSearchControllerTest {
     @isTest
     static void TestCustomerSearchControllerTest() {
        AccountModel model;  
        String jsonResponse = '{ "id":"ES348234988742C","name":"Jonh","lastName":"Erick","secondLastName":"Vargas","birthData":{"birthDate":"1985-10-02"},"identityDocument":{"documentType":{"id":"NIF"},"documentNumber":"12128494P"},"contactDetail":{"contact":{"contactDetailType":"LANDLINE","number":"916665432" }}}';
         
		
        Case caseTest = new Case(
       	    Origin = 'Formulario Público'
        );
        insert caseTest; 
         
        Case caseTestAux = new Case(
       	    Origin = 'Formulario Privado'
        );
        insert caseTestAux;
        
        Case caseTestAuxP = new Case(
       	    Origin = 'Facebook'
        );
        insert caseTestAuxP;  
         
        Test.startTest();
        model = AccountModel.getResults(jsonResponse);
        CustomerSearchController.searchCaseAndUpdateClient(caseTest.id,jsonResponse);
        CustomerSearchController.searchCaseAndUpdateClient(caseTestAux.id,jsonResponse);
        CustomerSearchController.searchCaseAndUpdateClient(caseTestAuxP.id,jsonResponse);
        Test.stopTest();
    }
}