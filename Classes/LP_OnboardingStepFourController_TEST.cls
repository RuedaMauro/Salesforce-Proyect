/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 15/06/2021
Description  : Test Class for LP_OnboardingStepFourController (step 4)
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Nelson Lepiqueo Lepiqueo	NLL
Leonardo Muñoz Garrido		LMG
Alan Sanhueza Carrasco		ASC
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      NLL			15/06/2021		initial version
********************************************************************************/
@isTest
public class LP_OnboardingStepFourController_TEST {

    private static LP_AccountsSelector accSelector;
    private static LP_LeadsSelector leadSelector;
    
    @testSetup 
    static void setupLead() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createAccountAndLeadWithRUT(true, nac);
        LP_DataFactory.createLeadBaseExpressWithRUT(true, nac);
	}
    
     /**
    * @description Test for method getStaticResource
    * @Autor       NLL
    * @date        15/06/2021
    */    
    @isTest
    static void getStaticResourceTest(){
        
        Test.startTest();
        String resp = LP_OnboardingStepFourController.getStaticResource('LP_Test');
        System.assertNotEquals(resp, null);
        Test.stopTest();
    }
    
     /**
    * @description Test for method extStaticResource
    * @Autor       NLL
    * @date        15/06/2021
    */    
    @isTest
    static void extStaticResourceTest(){
        
        Test.startTest();
        LP_OnboardingStepFourController resp = LP_OnboardingStepFourController.extStaticResource();
        System.assertNotEquals(resp.objImgList, null);
        Test.stopTest();
    }
    
     /**
    * @description Test for method updateLeadOrAccount - Update Lead
    * @Autor       NLL
    * @date        15/06/2021
    */ 
    @isTest
    static void updateLeadOrAccount1Test(){
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead obj = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);

        obj.Street = 'Recabarren';
        obj.City = 'Temuco';
        obj.State = 'Cautin';
        obj.Country = 'Chile';
        obj.LP_FechaPago__c = '5';
        obj.LP_Ocupacion__c = 'Estudiante';
        obj.LP_NivelEducacional__c = 'Postgrado';
        
        Map<String,String> res = LP_OnboardingStepFourController.updateLeadOrAccount(obj);
        System.assertNotEquals(res, null);
        Test.stopTest();
    }
    /**
    * @description Test for method updateLeadOrAccount - Update Account
    * @Autor       NLL
    * @date        15/06/2021
    */ 
    @isTest
    static void updateLeadOrAccount2Test(){
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead obj = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);

        obj.Street = 'Recabarren';
        obj.City = 'Temuco';
        obj.State = 'Cautin';
        obj.Country = 'Chile';
        obj.LP_FechaPago__c = '5';
        obj.LP_Ocupacion__c = 'Estudiante';
        obj.LP_NivelEducacional__c = 'Postgrado';
        
        Map<String,String> res = LP_OnboardingStepFourController.updateLeadOrAccount(obj);
        System.assertNotEquals(res, null);
        Test.stopTest();
    }
    /**
    * @description Test for method Validation BeClever
    * @Autor       ASC
    * @date        15/06/2021
    */
    @isTest
    static void validateClientBeCleverTest(){
        leadSelector = new LP_LeadsSelector();
        Lead obj = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        String azurianToken = '210f6c6e-da92-41a6-9b50-8a067ed37e19';
        Test.startTest();
                    
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionAzurian'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionBeClever'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AZVLD);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_BECLEVER);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String wrp = LP_OnboardingStepFourController.validateClientBeClever(obj, azurianToken, null);
        
        System.assertNotEquals(wrp, null, 'OK validateClientBeClever');
        Test.stopTest();
    }
    /**
    * @description Test for method Validation Api Google Autocomplete
    * @Autor       LMG
    * @date        16/06/2021
    */
    @isTest
    static void testGetAddressAutoComplete(){
		
        String addressInput ='Brisas del Maipo 2121-72';
        String addressEndpoint ='Brisas+del+Maipo+2121-72';
        String keyEndpoint = 'AIzaSyCyVKkNX5icE3-l83DQEsakcEaIPPXn1Bg';
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();   
        
        Test.startTest();
        endPoint.add(LP_RestMock_TEST.getEndPoint('Google_Maps', 'GoogleMapsAutoComplete') + addressEndpoint+'&key='+keyEndpoint);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_APIGOOGLE_AUTOCOMPLETE);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepFourController.getAddressAutoComplete(addressInput);
        
        System.assertNotEquals(response, null, 'OK validate');
        Test.stopTest();
    }
    /**
    * @description Test for method Validation Api Google Detail Address
    * @Autor       LMG
    * @date        16/06/2021
    */
    @isTest
    static void testGetAddressDetails(){
		String placeId = 'EidCcmlzYXMgZGVsIE1haXBvIDIxMjEtNzIsIFRlbXVjbywgQ2hpbGUiMRIvChQKEgkBuEF2KtQUlhEt6n6KYl57PhDJECoUChIJM9lMzYHWFJYRT2YQwntjDOY';
        String keyEndpoint = 'AIzaSyCyVKkNX5icE3-l83DQEsakcEaIPPXn1Bg';
        Test.startTest();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.getEndPoint('Google_Maps', 'GoogleMapsAutoDetail') + placeId+'&key='+keyEndpoint);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_APIGOOGLE_DETAIL);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepFourController.getAddressDetails(placeId);
        
        System.assertNotEquals(response, null, 'OK validate');
        Test.stopTest();
    }
    
    /**
    * @description Test for method Validation updateOnboardingStep
    * @Autor       Luis
    * @date        3/09/2021
    */
    @isTest
    static void updateOnboardingStepTest(){
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead obj = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);

        Map<String,String> res = LP_OnboardingStepFourController.updateOnboardingStep(obj);
        //System.assertNotEquals(res, null);
        Test.stopTest();
    }
}