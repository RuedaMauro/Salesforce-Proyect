/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 19/05/2021
Description  : Test Class LP_RestConnectionWithAuth
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            19/05/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_RestConnectionWithAuth_TEST {

    public static final string APP_JSON = LP_RestMock_TEST.PBC_STR_APPJSON;
    public static Map<String, Map<String, String>> setConf {get; set;}

    /**
    *  @Description: Initialization SetConf
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    public static void starSetConf() {      
        Map<String, String> headerParam = new Map<String, String>();
        headerParam.put('content-type',APP_JSON);
        headerParam.put('Authorization','');
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> queryParam = new Map<String, String>();
        setConf = new Map<String, Map<String, String>>();
        setConf.put('header',headerParam);
        setConf.put('path',pathParam);
        setConf.put('query',queryParam);
    }

    /**
    *  @Description: Test the callServiceWithToken method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest 
    static void callServiceWithTokenTest() {
        starSetConf();
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ValidacionOTP');
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionOTP'));
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_OTP);
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);        
        HTTPResponse response = objClass.callServiceWithToken (setConf, '');
        System.assertEquals(!String.isBlank(response.getBody()), true, 'It Worked');
        Test.stopTest();
    }

    /**
    *  @Description: Test the createErrorService method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        19/05/2021
    */
    @isTest
    static void createErrorServiceTest() {
        starSetConf();        
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ValidacionOTP');
        Test.setMock(httpcalloutmock.class, new LP_RestMock_TEST('',APP_JSON, 500, 'Unexpected error...'));
        Test.startTest();
        try {
            String guid = LP_RestConnectionUtility.getGUID();
            HTTPResponse response = objClass.callService(setConf, '');
        } catch(Exception e) {
            System.assertEquals(e != null, true, 'the error has been thrown');
        }
        Test.stopTest();
    }
}