/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-24-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class SocialMediaService {
    public static void socialMediaServiceOfClient(String caseId, AccountModel response) {

      Account accountClient = new Account();
      Account accountClientIfExisting = new Account();
      Contact contactClientIfExisting = new Contact();


      accountClientIfExisting = getAccountsByClient(response.identityDocument.documentNumber, response.name + ' ' + response.secondLastName+ ' ' + response.lastName);

      if(accountClientIfExisting != null ){

        AccountModel.updateAccountFromParser(accountClientIfExisting, response);
        linkSocialPersona(accountClientIfExisting.id);
        updateCase(caseId,accountClientIfExisting.id,accountClientIfExisting.PersonContactId);

      }else if(accountClientIfExisting == null){   

        accountClientIfExisting = AccountModel.getAccountFromParser(response);        
        updateCase(caseId,accountClientIfExisting.id,accountClientIfExisting.PersonContactId);
		
      }else{
        System.debug('An unexpected error has occurred');
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

    private static Contact getContactsByClient(String numberOfDocument, String nameOfClient) {
      Contact result = [SELECT Id 
                         FROM Contact 
                         WHERE name =: nameOfClient
                         AND CRM_SCC_DocumentNumber__c =: numberOfDocument
                         WITH SECURITY_ENFORCED  LIMIT 1];
      return result;
  }
  public static SocialPersona linkSocialPersona(String accountIdClient){
      try{
          SocialPersona socialPer = [SELECT ParentId
									                   FROM SocialPersona
                                     WHERE ParentId =: accountIdClient
                                     WITH SECURITY_ENFORCED  LIMIT 1];
          
          socialPer.ParentId = accountIdClient;   
          update socialPer;
          return socialPer;
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