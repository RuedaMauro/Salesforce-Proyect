/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_OnboardingSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            16/06/2021	   	    Created Class
********************************************************************************/
@isTest
public without sharing class LP_OnboardingSelector_TEST {
    
    private static LP_OnboardingSelector onbSelector;
    private static LP_AccountsSelector accSelector;
    private static LP_LeadsSelector leadSelector;

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        Lead lead = LP_DataFactory.createLeadWithRUT(true, nac);
        Account acc = LP_DataFactory.createAccount(true, nac);
        LP_Onboarding__c onbRcd = LP_DataFactory.createLP_Onboarding(true, lead);
        LP_Onboarding__c onbRcdAcc = LP_DataFactory.createOnboardingWithAcc(true, acc);
	}

    /**
    *  @Description: Test the selectById method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByIdTest() {
        Test.startTest();
        onbSelector = new LP_OnboardingSelector();
        Id onbId = onbSelector.selectByLeadRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD).Id;
        List<LP_Onboarding__c> onb = onbSelector.selectById(new Set<Id>{onbId});
        System.assertEquals(onb.size() > 0, true, 'The Onboarding record has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test the selectByLeadIdWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByLeadIdWithLimitTest() {
        Test.startTest();
        onbSelector = new LP_OnboardingSelector();
        leadSelector = new LP_LeadsSelector();
        Id leadId = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD).Id;
        LP_Onboarding__c onb = onbSelector.selectByLeadIdWithLimit(leadId);
        System.assertEquals(onb != Null, true, 'The Onboarding record has been returned');
        Test.stopTest();
    }

	/**
    *  @Description: Test the selectByLeadRutWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByLeadRutWithLimitTest() {
        Test.startTest();
        onbSelector = new LP_OnboardingSelector();
        LP_Onboarding__c onb = onbSelector.selectByLeadRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        System.assertEquals(onb != Null, true, 'The Onboarding record has been returned');
        Test.stopTest();
    }

	/**
    *  @Description: Test the selectByAccountIdWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByAccountIdWithLimitTest() {
        Test.startTest();
        onbSelector = new LP_OnboardingSelector();
        accSelector = new LP_AccountsSelector();
        Id accId = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT).Id;
        LP_Onboarding__c onb = onbSelector.selectByAccountIdWithLimit(accId);
        System.assertEquals(onb != Null, true, 'The Onboarding record has been returned');
        Test.stopTest();
    }

	/**
    *  @Description: Test the selectByAccountRutWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByAccountRutWithLimitTest() {
        Test.startTest();
        onbSelector = new LP_OnboardingSelector();
        LP_Onboarding__c onb = onbSelector.selectByAccountRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        System.assertEquals(onb != Null, true, 'The Onboarding record has been returned');
        Test.stopTest();
    }
}
