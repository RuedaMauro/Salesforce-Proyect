/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/06/2021
Description  : Test Class LP_EmailTemplatesSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Laura Malave B			    LMB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      LMB            17/08/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_EmailTemplatesSelector_TEST {
    
    private static LP_EmailTemplatesSelector EmailTemplateSelector;    

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        Account acc = LP_DataFactory.createAccount(true, nac);
        User usr = LP_DataFactory.createUser(acc);
        System.runAs ( usr ) {
        LP_DataFactory.createEmailTemplate(true, usr);
        }
	}

     /**
    *  @Description: Test the selectByEmailTemplateDeveloperNameWithLimit method
    *  @Autor:       Laura Malavé, Deloitte, atejoso@deloitte.com
    *  @Date:        17/08/2021
    */
    @isTest 
    static void selectByEmailTemplateDeveloperNameWithLimittest() {
        Test.startTest();
        EmailTemplateSelector = new LP_EmailTemplatesSelector();     
        String v1 = 'Email_First_Response';
        EmailTemplate template  = EmailTemplateSelector.selectByEmailTemplateDeveloperNameWithLimit(v1);
        System.assertEquals(template != Null, true, 'The EmailTemplate record has been returned');
        Test.stopTest();
    }

   


}