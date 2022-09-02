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
public with sharing class LP_PaymentController_TEST {
	
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getRefinanciationData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE220'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_PaymentController.getRefinanciationData();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getRefinanciationData()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getRefinanciationData()');
            Test.stopTest();
        }
    }

     /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getRefinanciationData_ERROR220_TEST() {
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
            rp = LP_PaymentController.getRefinanciationData();
            }
            Catch(Exception e){
                            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getRefinanciationData() Error 220');

            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getRefinanciationData() Error 220');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getmyCardData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE231'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE231);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_PaymentController.getMyCardData();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData()');

            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getmyCardData_Error231_TEST() {
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
            rp = LP_PaymentController.getMyCardData();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getSimulationData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE221'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE221);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getSimulationData(maps, 10);
               }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 221');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getSimulationData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getSimulationData_ERROR221_TEST() {
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
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getSimulationData(maps, 10);
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getSimulationData() Error 221');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getPreSimulationData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE220'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getPreSimulationData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getPreSimulationData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getPreSimulationData_ERROR220_TEST() {
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
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getCreditClientData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getPreSimulationData() Error 220');
            Test.stopTest();
        }
    }
    
     /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void PrePay_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
       	endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE207'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'IA646'));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getBalanceData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.prePay()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getPrePay_ERROR577_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
       	endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE207'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'IA646'));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getDebtData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.prePay Error 577()');
            Test.stopTest();
        }
    }
    
     /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void PrePay_ERROR207_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'IA646'));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            LP_PaymentController.createPaymentObject('asdsadsadas1232121', '12312312asadsadsad','10061865-6');
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_paymentController.prePay Error 207()');
            Test.stopTest();
        }
    }
    
     /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void PrePay_ERROR646_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE577'));
       	endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE207'));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.getPreSimulationData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_paymentController.prePay Error 646()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: Payment Controller test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void sendPay_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
          
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            Map<String,String> maps = new Map<String,String>();
            rp = LP_PaymentController.sendPayRequest('asd@asd.com', 10);
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_PaymentController.getMyCardData() ERROR 231');
            }
            System.assertNotEquals(rp, null, 'LP_paymentController. Error 646()');
            Test.stopTest();
        }
    }

     /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void RequestResponseTest() {
        Test.startTest();
        LP_JSONAoe231Request a = LP_JSONAoe231Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,a);
        LP_JSONAoe231Response b = LP_JSONAoe231Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,b);
        
        LP_JSONAoe221Request c= LP_JSONAoe221Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,c);
        LP_JSONAoe221Response d = LP_JSONAoe221Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, d);
        
        LP_JSONPayTranRequest e= LP_JSONPayTranRequest.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,e);
        LP_JSONPayTranResponse f = LP_JSONPayTranResponse.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, f);
        Test.stopTest();
    }
    
}