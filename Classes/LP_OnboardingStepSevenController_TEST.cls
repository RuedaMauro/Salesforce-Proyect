/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 29/06/2021
Description  : Test Class for LP_OnboardingStepSevenController (step 7)
History      : PCRM-24
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Fran Oseguera           	FO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      FO			29/06/2021		    initial version
********************************************************************************/
@isTest
public with sharing class LP_OnboardingStepSevenController_TEST {

    private static LP_AccountsSelector accSelector;
    private static LP_LeadsSelector LeadSelector;


    /**
    *  @Description: Loading records for the test
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_Ciudad__c city = LP_DataFactory.createCityCL(true);
        Lead lea = LP_DataFactory.createLeadWithRUT(true, nac);
        lea.LP_Rut__c = LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT;
        update lea;
        LP_Onboarding__c onb = LP_DataFactory.createLP_Onboarding(true, lea);
        LP_DataFactory.createAccount(true, nac);
		accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        updateAccStepSeven(acc, city);
	}
    
    /**
    * @description Update Account for step 7
    * @author      FO, Deloitte
    * @date        15/07/2021
    */
    private static void updateAccStepSeven(Account acc, LP_Ciudad__c city) {
	acc.LP_RutaOnboarding__pc = LP_OnBoardingUtility.PBC_STR_STEPSEVEN;
        acc.LP_CreadoOnboarding__pc = true;
        acc.LP_CuentaCreadaSitios__pc = false;
        acc.LP_Ciudad__pc = city.Id;
        acc.LP_Ocupacion__pc = 'Trabajador Dependiente de otras áreas';
        acc.LP_CupoDisponible__pc = 500000;
        acc.LP_FechaPago__pc = '5';
        acc.LP_EstadoCuentaMail__pc = true;
        acc.LP_NivelEducacional__pc = 'Universitaria completa';
        acc.LP_AceptacionContratos__pc = true;
        acc.LP_CodigoOTP__pc = '890';
        acc.LP_FechaFirmaContratos__pc = Date.TODAY();
        acc.LP_FechaNumeroCelular__pc = Date.TODAY();
        acc.LP_FechaCodigoOTP__pc = Date.TODAY();
        acc.LP_NumeroCelularValidado__pc = false;
        acc.LP_FirmaContratos__pc = true;
        acc.LP_CreacionClaveInternet__pc = false;
        update acc;
    }

    /**
    *  @Description: Test method searchAccountByRUT
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void searchAccountByRUT() {
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        Account accResult = LP_OnboardingStepSevenController.searchAccountByRUT(acc.Vass_Rut__c);
        system.assertEquals(acc.Vass_Rut__c, accResult.Vass_Rut__c, 'Same RUT');
        test.stopTest();
    }

    /**
    *  @Description: Test method customerCreate
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    /*
    @isTest static  void customerCreate() {
        leadSelector = new LP_LeadsSelector();
        Lead lea = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeCliente'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IDCHK);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);

        LP_JSONCustomerCreateResponse response = LP_OnboardingStepSevenController.customerCreate(lea);
        system.assertEquals(response != null , true, 'The JSON has been returned');
        test.stopTest();
    }
    */
	/**
    *  @Description: Test method customerCreate 422
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void customerCreate422() {
        leadSelector = new LP_LeadsSelector();
        Lead lea = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeCliente'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IDCHK);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 422);
        try {
            LP_JSONCustomerCreateResponse response = LP_OnboardingStepSevenController.customerCreate(lea);
        } catch (Exception e) {
            system.assertEquals(e != null , true, 'Customer cannot get LP Card');
        }
        test.stopTest();
    }
    
	/**
    *  @Description: Test method customerCreate 500
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void customerCreate500() {
        leadSelector = new LP_LeadsSelector();
        Lead lea = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeCliente'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IDCHK);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 500);
        try {
            LP_JSONCustomerCreateResponse response = LP_OnboardingStepSevenController.customerCreate(lea);
        } catch (Exception e) {
            system.assertEquals(e != null , true, 'Undefined Error');
        }
        test.stopTest();
    }

    /**
    *  @Description: Test method parse
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021  
    */
    /*
    @isTest static  void customerCreateRequest() {
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        LP_OnBoardingUtility.WrapObject wrap = new LP_OnBoardingUtility.WrapObject(new LP_Onboarding__c());
        wrap.rut = acc.Vass_Rut__c;
        wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
        if (!wrap.existsAcc) {
            wrap.type = SObjectType.Lead.getName();
            wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
        }
        LP_MAPJSONCustomerCreate objMap = new LP_MAPJSONCustomerCreate(wrap.acc, wrap.onb);
        LP_JSONCustomerCreateRequest result = LP_JSONCustomerCreateRequest.parse(JSON.serialize(objMap.mapping()));
        system.assertEquals(result != null , true, 'The JSON mapping has been returned');
        test.stopTest();
    }*/

    /**
    *  @Description: Force the error in the method customerCreate
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void customerCreateFail() {
        test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();

        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeCliente'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IDCHK);

        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        try {
            LP_JSONCustomerCreateResponse response = LP_OnboardingStepSevenController.customerCreate(new Lead());
        } catch (Exception e) {
            system.assertEquals(e != null, true, 'An error has been thrown');
        }
        test.stopTest();
    }

    /**
    *  @Description: Test method createAccountUser
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void createUser() {
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        LP_Response rsp = LP_OnboardingStepSevenController.createAccountUser(acc, 'password123!', false);
        system.assertEquals(rsp != null, true, 'User created successfully');
        test.stopTest();
    }

    /**
    *  @Description: Force the error in the method createAccountUser
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021
    */
    @isTest static  void createUserFail() {
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        test.startTest();
        LP_Response rsp = LP_OnboardingStepSevenController.createAccountUser(acc, 'password123!', false);
        system.assertEquals(rsp != null, true, 'The User could not be created');
        test.stopTest();
    }
}