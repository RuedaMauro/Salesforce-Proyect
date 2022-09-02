/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Tests for LP_MyDigitalCardController class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio	DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			19/07/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_MyDigitalCardController_TEST {
    
    
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getMyCardData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE279'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE1233'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1233);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
             rp = LP_MyDigitalCardController.getMyCardData();  
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData()');
            } 
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData()');
            Test.stopTest();
        } 
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getMyCardData_ERROR577_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        //endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE1233'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1233);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
              rp = LP_MyDigitalCardController.getMyCardData();  
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData() Error 577');
            } 
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData() Error 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getMyCardData_ERROR1233_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE279'));
        //endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE1233'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1233);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
               rp = LP_MyDigitalCardController.getMyCardData(); 
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData() ERROR 1233');
            } 
            
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getMyCardData() ERROR 1233');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getCreatedPinData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
               rp = LP_MyDigitalCardController.getCreatedPinData();
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData()');
            } 
            
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getCreatedPinData_ERROR577_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        //endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
               rp = LP_MyDigitalCardController.getCreatedPinData();
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData() ERROR 577');
            } 
           
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData() ERROR 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getCreatedPinData_ERROR68_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        //endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            
            try{
              rp = LP_MyDigitalCardController.getCreatedPinData();
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData() ERROR 68');
            } 
            
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.getCreatedPinData() ERROR 68');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void CreatePin_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE966'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE966);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
              rp = LP_MyDigitalCardController.CreatePin('4786882824843703','3276');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.CreatedPin()');
            } 
            
            System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.CreatedPin()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/    
    @isTest
    public static  void CreatePin_ERROR966_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        //endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE966'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE966);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
              rp = LP_MyDigitalCardController.CreatePin('4786882824843703','3276');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.CreatedPin()');
            } 
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void LP_MyDigitalCardController_ResendOTP_TEST() {
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionOTP'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
                      rp = LP_MyDigitalCardController.ResendOTP(12345678, '9', '33334444');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP()');
            }
        
        

        System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP()');
        Test.stopTest(); 
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void LP_MyDigitalCardController_ResendOTPError_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
        try{
                     rp = LP_MyDigitalCardController.ResendOTP(12345678, '9', '33334444');
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP() ERROR');
            }
        
     
        System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP() ERROR');
        Test.stopTest();
        
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void LP_MyDigitalCardController_CreatedPinInformation_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        rp.tarjetaEmitidaPan = '4786882219936989';
        rp.centalta = '0070';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
        try{
            rp = LP_getCreatedPinInformation.getCreatedPinInformationCall(rp);
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP() ERROR');
            }
        
     
        System.assertNotEquals(rp, null, 'NOT OK LP_MyDigitalCardController.ResendOTP() ERROR');
        Test.stopTest();
        
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void RequestResponse_TEST() {
        Test.startTest();
        LP_JSONAoe1233Request a= LP_JSONAoe1233Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,a);
        LP_JSONAoe1233Response b= LP_JSONAoe1233Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,b);
        
        LP_JSONAoe68Request f= LP_JSONAoe68Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,f);
        LP_JSONAoe68Response fr= LP_JSONAoe68Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,fr);
        
        LP_JSONAoe966Request d= LP_JSONAoe966Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,d);
        LP_JSONAoe966Response c= LP_JSONAoe966Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,c);
        
        LP_JSONAoe279Request e= LP_JSONAoe279Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,d);
        LP_JSONAoe279Response g= LP_JSONAoe279Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,c);
        Test.stopTest();
    }
    
}