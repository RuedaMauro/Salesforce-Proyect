/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-23-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class PrivateFormService {
    
  public static void privateFormServiceOfClient(String caseId, AccountModel response) {

    String accountName = response.name + ' ' + response.secondLastName+ ' ' + response.lastName;
    Account accountClient = new Account();
    Account accountClientIfExisting = new Account();

    accountClientIfExisting = getAccountsByClient(response.identityDocument.documentNumber,accountName);
    system.debug('ACCOUNTPRIVATE*****'+accountClientIfExisting);
    if(accountClientIfExisting != null ){

        AccountModel.updateAccountFromParser(accountClientIfExisting, response);
        //contactClientIfExisting = getContactsByClient(response.identityDocument.documentNumber, response.name + ' ' + response.secondLastName+ ' ' + response.lastName);
        updateCase(caseId,accountClientIfExisting.id,accountClientIfExisting.PersonContactId);
    }
    
  }

  private static Account getAccountsByClient(String numberOfDocument, String nameOfClient) {
   	  try{
          Account result = [SELECT Id,CRM_SCC_DocumentNumber__c,Phone,PersonContactId
                            FROM Account 
                            WHERE name =: nameOfClient 
                            AND CRM_SCC_DocumentNumber__c =: numberOfDocument 
                            WITH SECURITY_ENFORCED  LIMIT 1];    
          return result;
      }Catch(System.QueryException e){
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