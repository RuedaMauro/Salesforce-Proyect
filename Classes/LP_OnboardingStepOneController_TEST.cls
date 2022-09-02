/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_OnboardingStepOneController
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			16/06/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_OnboardingStepOneController_TEST {

    private static LP_LeadsSelector leadSelector;
    private static LP_OnboardingSelector onbSelector;
    private static LP_AccountsSelector accSelector;
    private static LP_NacionalidadesSelector countrySelector;

    @testSetup 
    static void setupMethod() {
        Test.startTest();
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        Lead objLead = LP_DataFactory.createLeadWithRUT(true, nac);
        LP_Onboarding__c onb = LP_DataFactory.createLP_Onboarding(true, objLead);
        Test.stopTest();
	}
    
    /**
    * @description Test init method
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        26/04/2021
    */ 
    @isTest static void initClassTest() {
        Test.startTest();
        LP_OnboardingStepOneController objClass = LP_OnboardingStepOneController.initClass();
        System.assertNotEquals(objClass, null, 'The data of path has been returned');
        Test.stopTest();
    }

    /**
    * @description Test lead record insert with google recaptcha v2 verification
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        26/04/2021
    */ 
    @isTest static void insertRecordWithLeadTest() {
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Test.startTest();
        string json = '{"success":true,"challenge_ts":"2021-06-18T16:50:27Z","hostname":"tarjetalapolar.cs195.force.com"}';
        Test.setMock(httpcalloutmock.class, new LP_RestMock_TEST('reCaptchaV2', LP_RestMock_TEST.PBC_STR_APPJSON, 200, json));
        objLead.MobilePhone = '945324567';
        String step = LP_OnboardingStepOneController.insertRecord(objLead, 'recaptchaResponse');
        System.assertNotEquals(!String.isEmpty(step), null, 'The step of path has been returned');
        Test.stopTest();
    }

    /**
    * @description Test Account record insert with google recaptcha v2 verification
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        26/04/2021
    */ 
    @isTest static void recordInsertionWithAccTest() {
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Test.startTest();
        countrySelector = new LP_NacionalidadesSelector();
        Account acc = LP_DataFactory.createAccount(true, countrySelector.selectByCodeWithLimit('CHL'));
        LP_Onboarding__c onb = LP_DataFactory.createOnboardingWithAcc(true, acc);
        objLead.MobilePhone = '945324567';
        objLead.LP_Rut__c = LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT;
        String step = LP_OnboardingStepOneController.recordInsertion(objLead);
        System.assertNotEquals(!String.isEmpty(step), null, 'The step of path has been returned');
        Test.stopTest();
    }
}
