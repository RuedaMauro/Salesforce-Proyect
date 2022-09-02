/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-20-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class CustomerSearchController {
  @AuraEnabled
  public static void searchCaseAndUpdateClient(String recordIdCase, String response){
        //SearchClientByEtherService(numberOfdocument);
        Case caseOfClient = [SELECT Id, Origin FROM Case WHERE Id =: recordIdCase WITH SECURITY_ENFORCED];

        AccountModel parseResponse = AccountModel.getResults(response);

        if(caseOfClient.Origin == 'Formulario Privado'){
          PrivateFormService.privateFormServiceOfClient(caseOfClient.Id, parseResponse);
        }else if(caseOfClient.Origin == 'Formulario Público'){
          PublicFormService.publicFormServiceOfClient(caseOfClient.Id, parseResponse);
        }else{
          if(caseOfClient.Origin != 'Teléfono' && caseOfClient.Origin != 'Interno'){
             SocialMediaService.socialMediaServiceOfClient(caseOfClient.Id, parseResponse);
          }
        }        
    }

}