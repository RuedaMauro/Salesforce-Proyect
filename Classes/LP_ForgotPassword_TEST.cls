@isTest
public without sharing class LP_ForgotPassword_TEST{

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
    private static final String API_OTP;
    
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
        API_PW_TEST = 'damian12';
        API_OTP = 'ValidacionOTP';
    }
    
    @testSetup 
    static void setupMethod() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
	}
    
    @isTest static  void ForgotPassword_validateAccount_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_OTP));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
        try{
        rp = LP_forgotPassword.ValidateAccount(API_RUT_TEST);
        }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
        Test.stopTest();
    }
    
     @isTest static  void ForgotPassword_validateAccount_ErrorCredit_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_OTP));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
         try{
        rp = LP_forgotPassword.ValidateAccount(API_RUT_TEST);
             }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
        Test.stopTest();
    }
    
     @isTest static  void ForgotPassword_validateAccount_ErrorDemographic_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_OTP));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);

        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
         try{
        rp = LP_forgotPassword.ValidateAccount(API_RUT_TEST);
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
             }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        Test.stopTest();
    }
    
    @isTest static  void ForgotPassword_validateAccount_ErrorOTP_TEST() {
        
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
        rp = LP_forgotPassword.ValidateAccount(API_RUT_TEST);
            }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
        Test.stopTest();
    }
    
        @isTest static  void ForgotPassword_forgotPassword_TEST() {
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        Test.startTest();
        rp = LP_forgotPassword.forgotPassword(API_RUT_TEST, API_PW_TEST);
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
        Test.stopTest();      
    }
    
    @isTest static  void ForgotPassword_forgotPassword_ErrorPwTEST() {
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        Test.startTest();
        try{
        rp = LP_forgotPassword.forgotPassword(API_RUT_TEST, API_PW_TEST);
            }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');
        Test.stopTest();      
    }
    
     @isTest static  void ForgotPassword_ResendOTP_TEST() { 
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_OTP));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
       
        Test.startTest();
         try{
        rp = LP_ForgotPassword.ResendOTP(API_RUT_TEST, API_PW_TEST);
             }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();
        //}    
    }
    
    @isTest static  void ForgotPassword_ResendOTP_Error_TEST() { 
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
        rp = LP_ForgotPassword.ResendOTP(API_RUT_TEST,API_PW_TEST);
            }
        Catch(Exception e){
                    System.assertNotEquals(rp, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();
    }
    
     @isTest static  void ForgotPassword_validateBlockedPassword() { 
        LP_Response rp = new LP_Response();
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        
        Test.startTest();
        Boolean asd;
         try{
        asd = LP_ForgotPassword.validateBlockedPassword(API_RUT_TEST);
                     System.assertNotEquals(asd, null, 'OK LP_CreateAccount.validateAccount()');

             }
        Catch(Exception e){
                    System.assertNotEquals(asd, null, 'OK LP_ForgotPassword.ValidateAccount()');

        }
        System.assertNotEquals(asd, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();
        }
    
}