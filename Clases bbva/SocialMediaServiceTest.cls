/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-26-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class SocialMediaServiceTest {
    @isTest
     static void testSocialMediaServiceTest(){
 	    
        AccountModel model;    
        Account accountIfExisting;
        Contact contactIfExisting;
        String jsonResponse = '{ "id":"ES348234988742C","name":"Jonh","lastName":"Erick","secondLastName":"Vargas","birthData":{"birthDate":"1985-10-02"},"identityDocument":{"documentType":{"id":"NIF"},"documentNumber":"12128494P"},"contactDetail":{"contact":{"contactDetailType":"LANDLINE","number":"916665432" }}}';
        String nameClient;
        
         Account acc = new Account(
            FirstName = 'Jonh Erick',
            LastName = 'Vargas', 
            CRM_SCC_DocumentNumber__c = '12128494P'
         );
         insert acc;
         
         Contact cont = new Contact(
            FirstName='Jonh Erick',
            LastName='Vargas',
            CRM_SCC_DocumentNumber__c = '12128494P'
        );
        insert cont;
 		
        SocialPersona spersona = new SocialPersona(
                Name = 'Social Person Test',
                ParentId = acc.Id,
                Provider = 'Facebook'
        );
        insert spersona;        
         
         Case caseTest = new Case(
       	    Origin = 'Formulario Privado',
            AccountId = acc.id
         );
         insert caseTest;
         
 
        nameClient = acc.FirstName + acc.LastName;
         
        
         Test.startTest();
         model = AccountModel.getResults(jsonResponse);
         SocialMediaService.linkSocialPersona(acc.id);
         accountIfExisting = AccountModel.getAccountFromParser(model);
         SocialMediaService.socialMediaServiceOfClient(caseTest.id,model);         
         Test.stopTest();
         
     }
}