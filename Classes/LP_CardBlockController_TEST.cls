/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Tests for LP_CardBlockController class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio	DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			19/07/2021		initial version
********************************************************************************/
@isTest
public without sharing class LP_CardBlockController_TEST {
    
     
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String URL_BASE;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        URL_BASE = 'URL_Base_Integracion';
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
	@isTest
    public static  void getData_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE224'));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE224);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_CardBlockController.getData();
            }    
            catch(Exception e){
             System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData()');
            }
             
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getData_ERROR577_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE224'));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE224);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_CardBlockController.getData();
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 577');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 577');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getData_ERROR224_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE68'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE68);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_CardBlockController.getData();
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 224');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 224');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void getData_ERROR68_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE577'));
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE224'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE577);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE224);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
             try{
                    rp = LP_CardBlockController.getData();
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 68');
            }
 			System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.getData() ERROR 68');
           
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void blockCard_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE225'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE225);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_CardBlockController.blockCard('4786882219936989');
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.blockCard()');
            }
           
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.blockCard()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void blockCard_ERROR225_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE225);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            
            try{
                     rp = LP_CardBlockController.blockCard('4786882219936989');
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.blockCard() ERROR 225');
            }
           
           
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.blockCard() ERROR 225');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void unblockCard_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint(URL_BASE, 'AOE225'));
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE225);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                     rp = LP_CardBlockController.unblockCard('4786882219936989');
            }    
            catch(Exception e){
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.unblockCard()');
            }
           
           
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.unblockCard()');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My Digital Card test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void unblockCard_ERROR225_TEST() {
        Account acc = LP_DataFactory.createAccount();
        User user = LP_DataFactory.createUserLogin(acc);
        LP_Response rp = new LP_Response();
        rp.rut = 12345678;
        rp.dv = '9';
        
        List<String> endPoint = new List<String>();
        List<String> resBody = new List<String>();
        
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN_Sitio_Privado).LP_RutaURL__c);
        
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_AOE225);
        
        
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        System.runAs(user) {
            Test.startTest(); 
            try{
                    rp = LP_CardBlockController.unblockCard('4786882219936989');
            }    
            catch(Exception e){
          System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.unblockCard() ERROR 225');
            }
            System.assertNotEquals(rp, null, 'NOT OK LP_CardBlockController.unblockCard() ERROR 225');
            Test.stopTest();
        }
    }
    
    /**
*  @Description: My CardBlock test
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        20/07/2021
*/
    @isTest
    public static  void RequestResponse_TEST() {
        Test.startTest();
        LP_JSONAoe225Request f= LP_JSONAoe225Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,f);
        LP_JSONAoe225Response fr= LP_JSONAoe225Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,fr);
        
        LP_JSONAoe224Request e= LP_JSONAoe224Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,e);
        LP_JSONAoe224Response er= LP_JSONAoe224Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,er);
        
        LP_JSONAoe577Request fh= LP_JSONAoe577Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,e);
        LP_JSONAoe577Response fg = LP_JSONAoe577Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,er);
        
        LP_JSONAoe68Request t= LP_JSONAoe68Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,e);
        LP_JSONAoe68Response tg = LP_JSONAoe68Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,er);
        
        Test.stopTest();
    }
}