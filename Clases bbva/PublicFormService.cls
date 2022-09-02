/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-24-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PublicFormService {
  //CONSOLE
      public static void publicFormServiceOfClient(String caseId, AccountModel response) {
        
        String accountName = response.name + ' ' + response.secondLastName+ ' ' + response.lastName;
        Account accountClient = new Account();
        Account accountClientIfExisting = new Account();
        Account contactClientIfExisting = new Account();
  
        accountClientIfExisting = getAccountsByClient(response.identityDocument.documentNumber, accountName);
  
        if(accountClientIfExisting != null ){
  
          AccountModel.updateAccountFromParser(accountClientIfExisting, response);
          updateCase(caseId,accountClientIfExisting.id,accountClientIfExisting.PersonContactId);
  
        }else if(accountClientIfExisting == null){   
  
          accountClientIfExisting = AccountModel.getAccountFromParser(response);
          contactClientIfExisting = getContactsByClient(accountClientIfExisting.id);
          updateCase(caseId,accountClientIfExisting.id,contactClientIfExisting.PersonContactId);
  
        }else{
          System.debug('An unexpected error has occurred');
        }
      }
  
      private static Account getAccountsByClient(String numberOfDocument, String nameOfClient) {
        try{
            Account result = [SELECT Id,CRM_SCC_DocumentNumber__c,Phone
                              FROM Account 
                              WHERE name =: nameOfClient 
                              AND CRM_SCC_DocumentNumber__c =: numberOfDocument 
                              WITH SECURITY_ENFORCED  LIMIT 1];    
            return result;
        }Catch(System.QueryException e){
            return null;
          }
      }
  
      private static Account getContactsByClient(String accountIdClient) {
        try{
            Account result = [SELECT PersonContactId 
                              FROM Account 
                              WHERE id =: accountIdClient
                              WITH SECURITY_ENFORCED  LIMIT 1];
            return result;
        }catch(System.QueryException e){
          return null;
        }
    }
    
    public static void updateCase(String caseId, String clientAccountId, String clientContactId){
    
      Case caseOfClient = [SELECT accountId, ContactId 
                           FROM Case 
                           WHERE id =: caseId 
                           WITH SECURITY_ENFORCED  LIMIT 1];
  
      caseOfClient.accountId = clientAccountId;
      caseOfClient.ContactId = clientContactId;
        if (!Schema.sObjectType.Case.fields.AccountId.isUpdateable()) {
            system.debug('error to update case');
        }        
        update caseOfClient;
      }
  }