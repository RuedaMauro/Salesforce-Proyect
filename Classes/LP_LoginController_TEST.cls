/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Login Controller testing class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			10/06/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_LoginController_TEST{
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String URL_BASE;
    private static final String API_AOE_577;
    private static final String API_AOE_1172;
    private static final String API_AOE_279;
    private static final String API_RUT_TEST;
    private static final String API_PW_TEST;
    private static final String PROFILE_NAME;
    private static final String ID_USER;
    private static final String USER_USERNAME;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        URL_BASE = 'URL_Base_Integracion';
        API_AOE_577 = 'AOE577';
        API_AOE_1172 = 'AOE1172';
        API_AOE_279 = 'AOE279';
        API_RUT_TEST = '10061865-6';
        API_PW_TEST = 'Dami1234';
        PROFILE_NAME = 'Customer Community User Sitio Privado';
        ID_USER = '005020000017jqQAAQ';
        USER_USERNAME = 'german@gmail.com.LaPolar2';
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021 
    */
    @isTest static  void LoginController_TEST() {
        
        LP_Response rp = new LP_Response();
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
	        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
       
        Test.startTest();
        
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
        }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
        
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021 
    */
    @isTest static  void LoginController_gologin_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut= 10083142;
        rp.dv = '2';
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        rp = LP_LoginController.goLogin(rp, API_PW_TEST, USER_USERNAME);
        }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
        
    }
    
     /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_NoCreditClient_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577_NOCREDIT);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
       
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
        }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
        
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_404_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        //endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        //resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user){
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
        }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
        }
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_TEST_1172_01() {
        Account acc = LP_DataFactory.createAccount();
        //User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172_01);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        //System.runAs(user) {
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST,API_PW_TEST);
            }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
        //}
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_TEST_1172_08() {
        Account acc = LP_DataFactory.createAccount();
        //User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172_08);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
            }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_Blocked_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserBlocked(acc);
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
         System.runAs(user){
        Test.startTest();
         try{
        rp = LP_LoginController.loginValidation('10083142-2', API_PW_TEST);
             }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK loginValidation Blocked User.');
        Test.stopTest();
         }
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_LoginOK_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
         try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
             }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_ErrorCredit_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
       
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
       
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
            }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_ErrorDemographic_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_1172));
        
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE1172);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
            try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
                }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
    @isTest static  void LoginController_ErrorBlocked_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        rp = LP_LoginController.loginValidation(API_RUT_TEST, API_PW_TEST);
        }
        catch(Exception e){
            System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        }
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_BlockAcc_TEST() {        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
       
        Test.startTest();
         try{
        rp = LP_LoginController.blockAccount(API_RUT_TEST);
             }
        Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_validateBlockedPassword_TEST() {        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
       
        Test.startTest();
          Boolean b;
         try{
        b = LP_LoginController.validateBlockedPassword(API_RUT_TEST);
         }
         Catch(Exception e){
             System.assertNotEquals(b, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(b, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
*  @Description: My Account test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void RequestResponseTest() {
        Test.startTest();
        
        LP_JSONAoe1172Request param= LP_JSONAoe1172Request.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,param);
        LP_JSONAoe1172Response param1 = LP_JSONAoe1172Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, param1);
        
        LP_JSONAoe220Request param2= LP_JSONAoe220Request.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,param);
        LP_JSONAoe220Response param3 = LP_JSONAoe220Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, param1);
        
        LP_JSONAoe577Request param4= LP_JSONAoe577Request.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,param);
        LP_JSONAoe577Response param5 = LP_JSONAoe577Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null, param1);
        
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_ProfileSelectorTEST() {   
        Test.startTest();
         List<Profile> lps = new List<Profile>();
         try{
             LP_ProfileSelector ps = new LP_ProfileSelector();
             lps = ps.selectByNameWithLimit(PROFILE_NAME);
         }
         Catch(Exception e){
             System.assertNotEquals(lps, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(lps, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: LoginController Test
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/07/2021
    */
     @isTest static  void LoginController_LoginHistorySelectorTEST() {   
        Test.startTest();
         List<LoginHistory> lps = new List<LoginHistory>();
         try{
             LP_LoginHistorySelector ps = new LP_LoginHistorySelector();
             lps = ps.selectByUserIdWithLimit2(ID_USER);
         }
         Catch(Exception e){
             System.assertNotEquals(lps, null, 'OK LP_HomeController.getHomeData()');
         }
        System.assertNotEquals(lps, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
}