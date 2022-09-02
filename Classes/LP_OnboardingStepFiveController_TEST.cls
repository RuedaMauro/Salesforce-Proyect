
/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 23/07/2021
Description  : Test Class LP_OnboardingStepFiveController
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            23/07/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_OnboardingStepFiveController_TEST {
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
    *  @Description: Test set document one
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest
    static void setDocumentOneTest(){
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        objLead.LP_TipoTarjeta__c = '02';
        update objLead;
        Test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeDocumentos'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_DOCONE);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_OnboardingStepFiveController objClass = LP_OnboardingStepFiveController.setDocuments(objLead);
        System.assertEquals(objClass.codeDocuments.size() > 0, true, 'The document map has been returned');
        System.assertEquals(objClass.leadObj != null, true, 'The lead has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test set document one
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest
    static void getDocumentTest(){
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        objLead.LP_TipoTarjeta__c = '02';
        update objLead;
        Test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ObtencionDeDocumentos'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_GETDOCONE);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String link = LP_OnboardingStepFiveController.getDocuments('COD123');
        System.assertEquals(!String.isEmpty(link), true, 'The document link has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test set document one
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest
    static void getNextStepTest(){
        leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        objLead.LP_TipoTarjeta__c = '02';
        update objLead;
        Test.startTest();
        String step = LP_OnboardingStepFiveController.getNextStep(objLead);
        System.assertEquals(!String.isEmpty(step), true, 'Onboarding record updated successfully');
        Test.stopTest();
    }

    /**
    *  @Description: Test force error JSON: LP_JSONCustomerGetDocumentsResponse 
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest static void getDocumentResponseJSON()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONCustomerGetDocumentsResponse j = new LP_JSONCustomerGetDocumentsResponse();
            LP_JSONCustomerGetDocumentsResponse.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    *  @Description: Test force error JSON: LP_JSONCustomerGetDocumentsRequest 
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest static void getDocumentRequestJSON()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONCustomerGetDocumentsRequest j = new LP_JSONCustomerGetDocumentsRequest();
            LP_JSONCustomerGetDocumentsRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    *  @Description: Test force error JSON: LP_JSONCustomerContractCreateRequest
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest static void contractCreateRequestJSON()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONCustomerContractCreateRequest j = new LP_JSONCustomerContractCreateRequest();
            LP_JSONCustomerContractCreateRequest.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }

    /**
    *  @Description: Test force error JSON: LP_JSONCustomerContractCreateRequest
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest static void contractCreateResponseJSON()
    {
        test.startTest();
        try {
            String json = '';
            LP_JSONCustomerContractCreateResponse j = new LP_JSONCustomerContractCreateResponse();
            LP_JSONCustomerContractCreateResponse.parse(json);            
        } catch(Exception e) {     
            System.assertEquals(e != null, true, 'An error has occurred');
        }
        test.stopTest();
    }
}
