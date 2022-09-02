/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 19/05/2021
Description  : Test Class LP_OnboardingStepTwoController_TEST
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            19/05/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_OnboardingStepTwoController_TEST {

    private static LP_LeadsSelector leadSelector;
    private static LP_OnboardingSelector onbSelector;
    private static LP_BasesExpressSelector xpressSelector;

    @testSetup 
    static void setupMethod() {
        leadSelector = new LP_LeadsSelector();
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createLeadBaseExpressWithRUT(true, nac);
        Lead objLead = leadSelector.selectByRutWithLeadCountry(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        LP_Onboarding__c onb = LP_DataFactory.createLP_Onboarding(true, objLead);
	}

    /**
    *  @Description: Test the call method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest 
    static void callToOtpServiceTest() {
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionOTP'));
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_OTP);
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);        
        String response = LP_OnboardingStepTwoController.callToOtpService(objLead, objLead.Email);
        System.assertEquals(!String.isBlank(response), true, 'It Worked');
        Test.stopTest();
    }

    /**
    *  @Description: Test the updateObjs method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest 
    static void updateObjsTest() {
        onbSelector = new LP_OnboardingSelector();
        LP_Onboarding__c objOnb = onbSelector.selectByLeadRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Lead objLead = (Lead)objOnb.LP_Candidato__r;
        system.debug('objOnb: ' + objOnb);
        Test.startTest();   
        Boolean response = LP_OnboardingStepTwoController.updateObjs(objLead, 'testlp@testlp.cl', '123456');
        System.assertEquals(response, true, 'It Worked');
        Test.stopTest();
    }

    /**
    *  @Description: Test Express Base Validation
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest
    static void expressBaseValidationTest() {
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        xpressSelector = new LP_BasesExpressSelector();
        LP_Base_Express__c xpress = xpressSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Test.startTest();        
        List<Object> objList = LP_OnboardingStepTwoController.expressBaseValidation(objLead);
        System.assertNotEquals(objList.size() > 0, null, 'OK Express Base');
        Test.stopTest();
    }

    /**
    *  @Description: Test customer Asset Laundering
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest
    static void customerAssetLaunderingTest(){
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        onbSelector = new LP_OnboardingSelector();
        LP_Onboarding__c objOnb = onbSelector.selectByLeadRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'LavadoActivos'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_ASL);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        List<Object> objAuxList = new List<Object>();
        objAuxList.add(objLead);
        objAuxList.add(objOnb);
        List<Object> objList = LP_OnboardingStepTwoController.customerAssetLaundering(objAuxList);        
        System.assertNotEquals(objList.size() > 0, null, 'OK AssetLaundering');
        Test.stopTest();
    }

    /**
    *  @Description: Test Equifax Validation
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest
    static void validateClientEquifaxTest(){
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        onbSelector = new LP_OnboardingSelector();
        LP_Onboarding__c objOnb = onbSelector.selectByLeadRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        Test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionEQUIFAX'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_ASL);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        List<Object> objAuxList = new List<Object>();
        objAuxList.add(objLead);
        objAuxList.add(objOnb);
        try {
            String step = LP_OnboardingStepTwoController.validateClientEquifax(objAuxList);
        } catch (Exception e) {
            System.assertEquals(e != null, true, 'Customer cannot get LP Card');
        }
        Test.stopTest();
    }

    /**
	*  @Description: Test force error JSON Response
	*  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
	*  @Date:        19/05/2021
	*/
    @isTest static void itShouldResponse()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONOTPResponse j = new LP_JSONOTPResponse();
            LP_JSONOTPResponse.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
	*  @Description: Test force error JSON Request
	*  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
	*  @Date:        19/05/2021
	*/
    @isTest static void itShouldRequest()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONOTPRequest j = new LP_JSONOTPRequest();
            LP_JSONOTPRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    * @description Test Json Asset Laundering Request
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        27/05/2021
    */    
    @isTest static void jsonAssetLaundRequestParseTest() {
        test.startTest();
        try {
            String json = '';
            LP_JSONAssetLaundRequest j = new LP_JSONAssetLaundRequest();
            LP_JSONAssetLaundRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    * @description Test Json Equifax Request
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        27/05/2021
    */    
    @isTest static void jsonEquifaxRequestParseTest() {
        test.startTest();
        try {
            String json = '';
            LP_JSONEquifaxRequest j = new LP_JSONEquifaxRequest();
            LP_JSONEquifaxRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }
    
    /**
    * @description Test Json Header Request
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        27/05/2021
    */    
    @isTest static void jsonHeaderRequestParseTest() {
        test.startTest();
        try {
            String json = '';
            LP_JSONHeaderRequest j = new LP_JSONHeaderRequest();
            LP_JSONHeaderRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    
    /**
    * @description Test Json Asset Laundering Response
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        27/05/2021
    */    
    @isTest static void jsonAssetLaundResponseParseTest() {
        test.startTest();
        try {
            String json = '';
            LP_JSONAssetLaundResponse j = new LP_JSONAssetLaundResponse();
            j.parse(json);
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    * @description Test Json Equifax Response
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        27/05/2021
    */    
    @isTest static void jsonEquifaxResponseParseTest() {
        test.startTest();
        try {
            String json = '';
            LP_JSONEquifaxResponse j = new LP_JSONEquifaxResponse();
            j.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }
}
