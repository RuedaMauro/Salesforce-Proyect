/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 03/06/2021
Description  : Test Class for LP_OnboardingStepThreeController (step 3)
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			03/06/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_OnboardingStepThreeController_TEST {

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createAccountAndLeadWithRUT(true, nac);
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        LP_DataFactory.createLP_Onboarding(true, objLead);
	}
    
    /**
    * @description Test customer Azurian Init
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        03/06/2021
    */    
    @isTest
    static void customerAzurianInitTest(){

        Test.startTest();
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        List<String> res = new List<String>();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionAzurian'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AZINI);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        res = LP_OnboardingStepThreeController.customerAzurianInit(objLead, null);
        
        System.assertNotEquals(res, null, 'OK ValidacionAzurian');
        Test.stopTest();
    }

    /**
    * @description Test customer Azurian Consult
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        03/06/2021
    */    
    @isTest
    static void customerAzurianConsultTest(){
        
        Test.startTest();
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        String ref = '210f6c6e-da92-41a6-9b50-8a067ed37e19';
        String res = '';
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionAzurian'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AZCON);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        res = LP_OnboardingStepThreeController.customerAzurianConsult(objLead, ref, null);
        
        System.assertNotEquals(res, null, 'OK ValidacionAzurian');
        Test.stopTest();
    }

    /**
    * @description Test customer Azurian Validate
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        10/06/2021
    */    
    @isTest
    static void customerAzurianValidateTest(){
         
        Test.startTest();
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        String ref = '210f6c6e-da92-41a6-9b50-8a067ed37e19';
        List<String> res = new List<String>();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionAzurian'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AZVLD);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        res = LP_OnboardingStepThreeController.customerAzurianValidate(objLead, ref, null);
        System.assertNotEquals(res, null, 'OK ValidacionAzurian');
        Test.stopTest();
    }

    /**
    * @description Test customer Ident Check
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        10/06/2021
    */    
    @isTest
    static void customerIdentCheckTest(){
        
        Test.startTest();
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        String ref = 'c68c6244-7d5c-4e52-a9e6-366ce6b12e05';
        String res = '';
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionIdentCheck'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IDCHK);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        res = LP_OnboardingStepThreeController.customerIdentCheck(objLead, ref);
        
        System.assertNotEquals(res, '', 'OK ValidacionIdentCheck');
        Test.stopTest();
    }   

    /**
    * @description Test get GUID Onboarding By RUT
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        10/06/2021
    */    
    @isTest
    static void  getGUIDOnboardingByRUTTest(){
        Test.startTest();
        String guid = 'c68c6244-7d5c-4e52-a9e6-366ce6b12e05';
        SObject obj = LP_OnboardingStepThreeController.getGUIDOnboardingByRUT(guid);
        Lead objLead = (Lead)obj;
        System.assertEquals(objLead, null, 'OK ValidacionIdentCheck');
        Test.stopTest();
    }

    /**
    * @description Test json azurian request
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        10/06/2021
    */
    @isTest
    static void jsonAzurianRequest(){
        test.startTest();
        try {
            String json = '';
            LP_JSONAzurianRequest objAzurian = new LP_JSONAzurianRequest();
            LP_JSONAzurianRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    * @description Test json ident check request
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        10/06/2021
    */
    @isTest
    static void jsonIdentCheckRequest(){
        test.startTest();
        try {
            String json = '';
            LP_JSONIdentCheckRequest objident = new LP_JSONIdentCheckRequest();
            LP_JSONIdentCheckRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }
}