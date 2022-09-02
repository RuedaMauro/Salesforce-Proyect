/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 09/08/2021
Description  : Test Class LP_LoginValidation
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			09/08/2021		initial version
********************************************************************************/
@isTest
public with sharing class LP_LoginValidation_TEST {

    private static LP_AccountsSelector accSelector;
    private static LP_UsersSelector userSelector;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    private static final String PRV_STR_RUT;
    private static final String PRV_STR_INTVECTOR;
    private static final String PRV_STR_PATH;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    static {
        PRV_STR_RUT = '19246239-8';
        PRV_STR_INTVECTOR = 'Example of IV123';
        PRV_STR_PATH = '/services/apexrest/V2/LoginValidation';
    }

    @testSetup
    static void setupMethod() {
        Test.startTest();
        accSelector = new LP_AccountsSelector();
        Account acc = LP_DataFactory.createAccount();
        Account accAux = accSelector.selectByRutWithLimit(acc.Vass_Rut__c);
        User user = LP_DataFactory.createUserLogin(accAux);
        Test.stopTest();
	}
    
    /**
    * @description Test init method
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        09/08/2021
    */
    @isTest static void loginTest() {
        Test.startTest();
        userSelector = new LP_UsersSelector();
        List<User> user = userSelector.selectByRutWithLimit(PRV_STR_RUT);
        Blob passBlob = Crypto.GenerateAESKey(128);
        String pass = EncodingUtil.ConvertTohex(passBlob);
        System.setPassword(user[0].id, pass);
        LP_JSONLoginValidationRequest logBody = new LP_JSONLoginValidationRequest();
        logBody.body = new LP_JSONLoginValidationRequest.Body();
        logBody.body.username = LP_LoginValidation.encrypt(user[0].RUT__c, PRV_STR_INTVECTOR);
        logBody.body.password = LP_LoginValidation.encrypt(pass, PRV_STR_INTVECTOR);
        logBody.body.initializationVector = EncodingUtil.base64Encode(Blob.valueOf(PRV_STR_INTVECTOR));              
        String str = JSON.serialize(logBody);
        RestRequest request = new RestRequest();
        request.requestUri = URL.getOrgDomainUrl().toExternalForm() + PRV_STR_PATH;
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(str);
        RestContext.request = request;
        Test.setMock(httpcalloutmock.class, new LP_RestMock_TEST('Login SOAP', LP_RestMock_TEST.PBC_STR_APPJSON, 200, LP_RestMock_TEST.PBC_STR_JSON_APILOGIN));
        LP_LoginValidation.LoginResponse login = LP_LoginValidation.login();
        System.assertEquals(login != Null, true, 'successfully logged in');
        Test.stopTest();
    }

    /**
    * @description Test init method
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        09/08/2021
    */
    @isTest static void loginErrorTest() {
        Test.startTest();
        userSelector = new LP_UsersSelector();
        List<User> user = userSelector.selectByRutWithLimit(PRV_STR_RUT);
        Blob passBlob = Crypto.GenerateAESKey(128);
        String pass = EncodingUtil.ConvertTohex(passBlob);
        System.setPassword(user[0].id, pass);
        LP_JSONLoginValidationRequest logBody = new LP_JSONLoginValidationRequest();
        logBody.body = new LP_JSONLoginValidationRequest.Body();
        logBody.body.username = LP_LoginValidation.encrypt(user[0].RUT__c, PRV_STR_INTVECTOR);
        logBody.body.password = LP_LoginValidation.encrypt(pass, PRV_STR_INTVECTOR);
        logBody.body.initializationVector = EncodingUtil.base64Encode(Blob.valueOf(PRV_STR_INTVECTOR));              
        String str = JSON.serialize(logBody);
        RestRequest request = new RestRequest();
        request.requestUri = URL.getOrgDomainUrl().toExternalForm() + PRV_STR_PATH;
        request.httpMethod = 'POST';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf(str);
        RestContext.request = request;
        LP_LoginValidation.LoginResponse login = LP_LoginValidation.login();
        System.assertEquals(login != Null, true, 'incorrectly logged in');
        Test.stopTest();
    }
}