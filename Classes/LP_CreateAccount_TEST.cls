/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 14/06/2021
Description  : Create account Tests Class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB

---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			14/06/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_CreateAccount_TEST{
    
     /**
    *  @Description: Initialization of static variabless
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String URL_BASE;
    private static final String API_AOE_207;
    private static final String API_AOE_220;
    private static final String API_AOE_577;
    private static final String API_AOE_279;
    private static final String API_Validator;
    private static final String API_RUT_TEST;
    private static final String API_PW_TEST;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        URL_BASE = 'URL_Base_Integracion';
        API_AOE_207 = 'AOE207';
        API_AOE_220 = 'AOE220';
        API_AOE_577 = 'AOE577';
        API_AOE_279 = 'AOE279';
        API_VALIDATOR = 'ValidacionOTP';
        API_RUT_TEST = '10061865-6';
        API_PW_TEST = 'damian12';
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ValidateAccount_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_Validator));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        
        rp = LP_CreateAccount.validateAccount(API_RUT_TEST);
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_createAccount_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        Test.startTest();
        Map<String,String> params = new Map<String,String>();
        params.put('last_Name_1', 'garcia');
        params.put('last_Name_2', 'garcia');
        params.put('name', 'garcia');
        params.put('no_movil', '10023945');
        params.put('email', 'email@email.com');
        params.put('rut', '10061865');
        params.put('dv', '6');
        params.put('password', 'passwor1');
        rp = LP_CreateAccount.createAccount(params);
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ResendOTP_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_Validator));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
  
        Test.startTest();
        
        rp = LP_CreateAccount.ResendOTP(API_RUT_TEST,API_PW_TEST);
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();  
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ResendOTPError_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        
        rp = LP_CreateAccount.ResendOTP(API_RUT_TEST, API_PW_TEST);
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest(); 
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ValidateAccount_ErrorCredit_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_Validator));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        	rp = LP_CreateAccount.validateAccount(API_RUT_TEST);
        }
        Catch(Exception e){
        	System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        }
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();  
    }	
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ValidateAccount_ErrorDemographic_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_Validator));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        try{
        rp = LP_CreateAccount.validateAccount(API_RUT_TEST);
        }
        Catch(Exception e){
       		System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');

        }
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest();  
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ValidateAccount_ErrorOTP_TEST() {
        
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
            rp = LP_CreateAccount.validateAccount(API_RUT_TEST);
        }
        catch(Exception e){
            System.assertEquals(e!=null, true, 'OK LP_CreateAccount.validateAccount()');
        }
        Test.stopTest(); 
    }
    
    /**
*  @Description: CreateAccount Test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest static  void CreateAccount_ValidateAccount_ErrorExistingAcc_TEST() {
        
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_Validator));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA995);
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        Test.startTest();
        
        rp = LP_CreateAccount.validateAccount(API_RUT_TEST);
        System.assertNotEquals(rp, null, 'OK LP_CreateAccount.validateAccount()');
        Test.stopTest(); 
    }
    
    
}