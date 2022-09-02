/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 19/05/2021
Description  : Test LP_MAPJSONAssetLaundValidation
History      : PCRM-12
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade             EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA		    19/05/2021		Created the class
********************************************************************************/
@isTest
public without sharing class LP_MAPJSONAssetLaundValidation_TEST {
    
    public static final string APP_JSON = LP_RestMock_TEST.PBC_STR_APPJSON;

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createAccountAndLeadWithRUT(true, nac);
	}
    
    @isTest
    static void callTest() {
        
        LP_LeadsSelector leadSelector = new LP_LeadsSelector();
        Lead objLead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        LP_NacionalidadesSelector nacSelector = new LP_NacionalidadesSelector();
        LP_Nacionalidad__c nac = nacSelector.selectByCodeWithLimit('CHL');
        
        Test.startTest();
        LP_MAPJSONAssetLaundValidation alv = new LP_MAPJSONAssetLaundValidation(objLead, (String)nac.LP_CodigoNacionalidad__c);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'LavadoActivos'));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_ASL);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        String rsp = alv.call();
        
        System.assertNotEquals(rsp, null, 'OK AssetLaundering');
        Test.stopTest();
    }
}