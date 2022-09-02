/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-20-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class AccountModel {
        
    public String id;
    public String name;
    public String secondLastName;
    public String lastname;
    public birthData birthData;
    public identityDocument identityDocument;
    public contactDetail contactDetail;
    public contact contact;


    public class birthData{
       public DateTime birthDate;
    }

    public class identityDocument{
        public string documentNumber;
    }

    public class contactDetail{
        public contact contact;
    }

    public class contact{
        public string numberCli;
    }

    public static AccountModel getResults(String jsonClient){
        jsonClient = jsonClient.replace('number', 'numberCli');
        return (AccountModel) System.JSON.deserialize(jsonClient, AccountModel.class);
    }

    public static Account getAccountFromParser(AccountModel model){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        Account acct = new  Account(
            RecordTypeId = accRecTypeId,
            firstName = model.name != null ? model.name + ' ' + model.secondLastName : null,
            lastName = model.lastName != null ? model.lastName : null,
            CRM_SCC_DocumentType__c =  'DNI', 
            CRM_SCC_DocumentNumber__c = model.identityDocument.documentNumber != null ? model.identityDocument.documentNumber : null,
            Phone = model.contactDetail.contact.numberCli != null ? model.contactDetail.contact.numberCli : null
        );
        insert acct;
        return acct;   
    }

    public static Account updateAccountFromParser(Account accountToUpdate,AccountModel model){
      Account auxAccount = new Account();
    
      auxAccount = accountToUpdate;

      auxAccount.CRM_SCC_DocumentType__c =  'DNI';
      auxAccount.CRM_SCC_DocumentNumber__c = model.identityDocument.documentNumber != null ? model.identityDocument.documentNumber : null;
      auxAccount.Phone = model.contactDetail.contact.numberCli != null ? model.contactDetail.contact.numberCli : null;
      auxAccount.PersonBirthdate = model.birthData.birthDate != null ? Date.valueOf(model.birthData.birthDate) : null;

      if (!Schema.sObjectType.Case.fields.AccountId.isUpdateable()) {
        system.debug('error to update case');
      }
      update auxAccount;
      return auxAccount;   
  }
}