/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Tests for LP_MyAccountController class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio	DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			19/07/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_MyAccountController_TEST {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String URL_BASE;
    private static final String API_AOE_577;
    private static final String API_AOE_189;
    private static final String API_AOE_214;
    private static final String API_AOE_215;
    private static final String API_AOE_207;
    private static final String API_RUT_TEST;
    private static final String API_PW_TEST;
    private static final String API_AOE_212;
    private static final String API_AOE_JSON;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        URL_BASE = 'URL_Base_Integracion';
        API_AOE_577 = 'AOE577';
        API_AOE_207 = 'AOE207';
        API_RUT_TEST = '10061865-6';
        API_PW_TEST = 'damian12';
        API_AOE_212 = 'AOE212';
        API_AOE_189 = 'AOE189';
        API_AOE_214 = 'AOE214';
        API_AOE_215 = 'AOE215';
        API_AOE_JSON = '{"clienteRut":"11111111","clienteDv":"2"}';
    }
    
    
    	/**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    	@isTest
    	public static  void getMyAccountData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountData();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getMyAccountData_577ERROR_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountData();
                 }
            Catch(Exception e){
                 System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData() Error 577');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData() Error 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getMyAccountData_207ERROR_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountData();
                }
            Catch(Exception e){
                 System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData() ERROR 207');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountData() ERROR 207');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
     @isTest
    	public static  void getMyAccountBalanceData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountBalanceData();
            }
            Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountBalanceData()');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountBalanceData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
     @isTest
    	public static  void getMyAccountBalanceData_Error207_TEST() {
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
            rp = LP_MyAccountController.getMyAccountBalanceData();
                }
            Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountBalanceData() ERROR 207');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountBalanceData() ERROR 207');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
     @isTest
    	public static  void getMyAccountDataFacturation_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_212));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE212);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountDataFacturation();
                 }
            Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountBalanceData() ERROR 207');
            }
            System.assertNotEquals(rp, null, 'NOT OK getMyAccountDataFacturation');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getMyAccountDataFacturation_ERROR577_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_212));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE212);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            rp = LP_MyAccountController.getMyAccountDataFacturation();
            }
            Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountDataFacturation ERROR 577');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountDataFacturation ERROR 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
     @isTest
    	public static  void getMyAccountDataFacturation_ERROR212_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getMyAccountDataFacturation();
            }
             Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountDataFacturation ERROR 212');
            }    
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountDataFacturation ERROR 212');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getMyAccountMovementsData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
       	endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_189));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE189);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            rp = LP_MyAccountController.getMyAccountMovementsData();
            }
             Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountMovementsData');
            }  
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountMovementsData');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getMyAccountMovementsData_ERROR189_TEST() {
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
            rp = LP_MyAccountController.getMyAccountMovementsData();
             }
             Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountMovementsData ERROR 189');
            }     
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getMyAccountMovementsData ERROR 189');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getClientTypeData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
       	endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            rp = LP_MyAccountController.getClientTypeData();
                 }
             Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getClientTypeData');
            } 
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getClientTypeData');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getClientTypeData_ERROR577_TEST() {
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
            rp = LP_MyAccountController.getClientTypeData();
             }
             Catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getClientTypeData ERROR 577');
            }     
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getClientTypeData ERROR 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getEECC_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
       	endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_214));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE214);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            	rp = LP_MyAccountController.getDocs();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs');
            Test.stopTest();
        }
    }
    
     /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getEECC_Nov_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
       	endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_214));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE214_NOV);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
            	rp = LP_MyAccountController.getDocs();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs Nov');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs Nov');
            Test.stopTest();
        }
    }
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getEECC_ERROR214_TEST() {
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
            rp = LP_MyAccountController.getDocs();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs Error 214');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    	public static  void getDocuments_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
       	endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_215));
            
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE215);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest();
            try{
            rp = LP_MyAccountController.getDocument(API_RUT_TEST, '5610100186050735', '20191027');
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocs');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_MyAccountController.getDocument');
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
        LP_JSONAoe212Request a = LP_JSONAoe212Request.parse(API_AOE_JSON);
        System.assertNotEquals(null,a);
        LP_JSONAoe212Response b = LP_JSONAoe212Response.parse(API_AOE_JSON);
        System.assertNotEquals(null,b);
        LP_JSONAoe189Request c= LP_JSONAoe189Request.parse(API_AOE_JSON);
        System.assertNotEquals(null,c);
        LP_JSONAoe189Response d = LP_JSONAoe189Response.parse(API_AOE_JSON);
        System.assertNotEquals(null, d);
        LP_JSONAoe214Request ert= LP_JSONAoe214Request.parse(API_AOE_JSON);
        System.assertNotEquals(null,c);
        LP_JSONAoe214Response tre = LP_JSONAoe214Response.parse(API_AOE_JSON);
        System.assertNotEquals(null, d);
        LP_JSONAoe215Request gfd= LP_JSONAoe215Request.parse(API_AOE_JSON);
        System.assertNotEquals(null,c);
        LP_JSONAoe215Response dff = LP_JSONAoe215Response.parse(API_AOE_JSON);
        System.assertNotEquals(null, d);
        LP_JSONAoe207Request param= LP_JSONAoe207Request.parse(API_AOE_JSON);
        System.assertNotEquals(null,param);
        LP_JSONAoe207Response param1 = LP_JSONAoe207Response.parse(API_AOE_JSON);
        System.assertNotEquals(null, param1);
        LP_JSONAoe646Request param2= LP_JSONAoe646Request.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,param);
        LP_JSONAoe646Response param3 = LP_JSONAoe646Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, param1);
        Test.stopTest();
    }
    
}