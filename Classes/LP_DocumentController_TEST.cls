/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 06/08/2021
Description  : Tests for LP_PaymentController class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio	DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			06/08/2021		initial version
********************************************************************************/
@isTest
public with sharing class LP_DocumentController_TEST {
	
    /**
*  @Description: Document Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        10/08/2021
*/
    	@isTest
    	public static  void getDocumentList_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE151'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE151);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_DocumentController.getDocumentList();
            }    
            catch(Exception e){
              System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            }
           
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Document Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        10/08/2021
*/
    	@isTest
    	public static  void getDemographic_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE279'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_DocumentController.LP_getDemographicDataClient();
            }    
            catch(Exception e){
              System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            }
           
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            Test.stopTest();
        }
    }
    
    	@isTest
    	public static  void getDocumentList_ERROR151_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
                   rp = LP_DocumentController.getDocumentList();
            }    
            catch(Exception e){
              System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentList()');
            Test.stopTest();
        }
    }
    
	 @isTest
    	public static  void getDocumentLink_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE103'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE103);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                   String asd = LP_DocumentController.getDocumentLink('1234566');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            Test.stopTest();
        }
    }
    
    @isTest
    	public static  void getDocumentLink_ERROR103_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                   String asd = LP_DocumentController.getDocumentLink('1234566');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            Test.stopTest();
        }
    }
    
     @isTest
    	public static  void getDataClient_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE1422'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE279'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1422);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
              rp = LP_DocumentController.LP_getDataClient();
            }    
            catch(Exception e){
              System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST()');
            Test.stopTest();
        }
    }
    
    @isTest
    	public static  void getDataClient_ERROR1422TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE279'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
               rp = LP_DocumentController.LP_getDataClient();
            }    
            catch(Exception e){
               System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST() ERROR 1422');
            }
           
            System.assertNotEquals(rp, null, 'NOT OK LP_DocumentController.getDocumentLink_TEST() ERROR 1422');
            Test.stopTest();
        }
    }
    
     @isTest
    public static  void RequestResponseTest() {
        Test.startTest();
        LP_JSONAoe103Request a = LP_JSONAoe103Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,a);
        LP_JSONAoe103Response b = LP_JSONAoe103Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,b);
        LP_JSONAoe151Request c= LP_JSONAoe151Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,c);
        LP_JSONAoe151Response d = LP_JSONAoe151Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, d);
        LP_JSONAoe1422Request e= LP_JSONAoe1422Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,c);
        LP_JSONAoe1422Response f = LP_JSONAoe1422Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, d);
        Test.stopTest();
    }

}