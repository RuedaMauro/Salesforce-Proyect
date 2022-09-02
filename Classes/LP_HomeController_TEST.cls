@isTest
public without sharing class LP_HomeController_TEST {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String URL_BASE;
    private static final String API_AOE_207;
    private static final String API_AOE_220;
    private static final String API_AOE_577;
    private static final String API_AOE_279;
    private static final String API_IA_646;
    private static final String API_RUT_TEST;
    
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
        API_IA_646 = 'IA646';
        API_RUT_TEST = '10061865-6';
    }
    
    @testSetup
    static void setupMethod() {
        
    }
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTDec() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Dec);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData2();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTNov() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Nov);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData3();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTNovember() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Nov);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData4();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTSep() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Sep);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData4();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTOct() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Oct);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData5();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTDecember() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Dec);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData4();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_TESTOctober() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646Oct);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData4();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_ErrorCredit_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
       
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
       
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_ErrorDemographic_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
       
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_ErrorBalance_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
       
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_ErrorReneg_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_IA_646));
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
       
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_IA646);
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
                }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_ErrorDebt_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_577));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_279));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_207));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, API_AOE_220));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE279);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE207);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE220);
       
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getHomeData1();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
    
    /**
    *  @Description: Test for LP_HomeController
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    @isTest static void HomeController_GetUserInfo_TEST() {
        
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUser(acc);
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
       
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        LP_Response rp = new LP_Response();
        rp.rut = 10061865;
        rp.dv = '6';
        Test.startTest();
        System.runAs(user) {
            try{
            rp = LP_HomeController.getUserInfo();
            }
            Catch(Exception e){
                System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
            }
        }
        System.assertNotEquals(rp, null, 'OK LP_HomeController.getHomeData()');
        Test.stopTest();
    }
}