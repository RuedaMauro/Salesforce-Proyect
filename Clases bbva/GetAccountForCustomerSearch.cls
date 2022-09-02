/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-28-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class GetAccountForCustomerSearch {
    @AuraEnabled(cacheable=true)
    public static String getAccountForCustomerSearchClient(String idCase) {
        String documentOfClient = getAccountFromCase(IdCase);
        
        
        if(documentOfClient != null){
        	String result = documentOfClient;
            system.debug('DOCUMENT*****'+ result);
        }else{
            documentOfClient = getContactFromCase(idCase);          
        }
        system.debug('DOCUMENTCONTACT*******'+documentOfClient);
        return documentOfClient;
    }

    public static String getAccountFromCase(String caseIdClient){
        String accountExisting;
        try{
            accountExisting = [SELECT id, CRM_SCC_DocumentNumber__c
            FROM Account 
            WHERE
            id IN
            (SELECT AccountId 
            FROM case WHERE id =: caseIdClient)
            WITH SECURITY_ENFORCED  LIMIT 1].CRM_SCC_DocumentNumber__c;

            system.debug('ACCOUNTIFEXISTING*****'+accountExisting);

            return accountExisting;
        }catch(System.QueryException e){
            return null;
        }
    }

    public static String getContactFromCase(String caseIdClient){
        String contactClient;
        try {
             contactClient = [SELECT id, CRM_SCC_DocumentNumber__c
                              FROM Contact 
                              WHERE
                              id IN
                              (SELECT ContactId 
                               FROM case WHERE id =: caseIdClient)
                              WITH SECURITY_ENFORCED  LIMIT 1].CRM_SCC_DocumentNumber__c;

             system.debug('CONTACTIFXISTING¨******'+contactClient);
			 return contactClient;

        } catch (System.QueryException e) {
            return null;
        }
    }

}