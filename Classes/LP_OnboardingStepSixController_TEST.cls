/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 23/07/2021
Description  : OnBoarding - Test class for LP_OnboardingStepSixController class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye         RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			23/07/2021		initial version
********************************************************************************/
@isTest
public class LP_OnboardingStepSixController_TEST {
    private static LP_LeadsSelector leadSelector;
    private static LP_OnboardingSelector onbSelector;
    private static LP_BasesExpressSelector xpressSelector;

    @testSetup 
    static void setupMethod() {
        LP_DataFactory.createLeadDataForOnboarding(LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL, LP_OnBoardingUtility.PBC_STR_STEPSIX);
        LP_DataFactory.createLeadDataForOnboarding(LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL, LP_OnBoardingUtility.PBC_STR_STEPSIX);
	}

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void getOTPCodeFromValidPhone_Test() {
        // se inicializa los endpoint
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionOTP'));
        // se inicializa los mock
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_OTP_BYPHONE);
        // codigo incluido en el recurso estatico
        String otpCode = '904780';
        // se genera la data del Lead en memoria
        Lead objLead = new Lead();
        objLead.LP_Rut__c = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.rut;
        objLead.FirstName = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.nombre;
        objLead.LastName = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.primerApellido;
        objLead.Email = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.email;
        objLead.MobilePhone = LP_DataFactory.clearPhonePrefix(LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.mobilePhone);
        // se inicia el test
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepSixController.getOTPCode(objLead, objLead.MobilePhone);
        System.assertEquals(response, otpCode, 'It´s Worked!');
        Test.stopTest();
    }

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void getOTPCodeFromInvalidPhone_Test() {
        // se inicializa los endpoint
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ValidacionOTP'));
        // se inicializa los mock
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_OTP_BYPHONE);
        // codigo incluido en el recurso estatico
        String otpCode = '904780';
        // se genera la data del Lead en memoria
        Lead objLead = new Lead();
        objLead.LP_Rut__c = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.rut;
        objLead.FirstName = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.nombre;
        objLead.LastName = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.primerApellido;
        objLead.Email = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.email;
        objLead.MobilePhone = LP_DataFactory.clearPhonePrefix(LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.mobilePhone);

        // se inicia el test
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        // se genera el número quemado
        try {
            LP_DataFactory.setStep6DataForOnboardingInvalidPhone(LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL);
        } catch (AuraHandledException e) {
            System.debug('exception e: ' + e);
            System.assertEquals(e != null, true, 'Exception catched!');
        }
        Test.stopTest();
    }

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void validateOTPCodeWithVisa_Test() {
        // se inicializa los endpoint
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeDocumentos'));
        // se inicializa los mock
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_CREATE_DOC8);
        // codigo incluido en el recurso estatico
        String otpCode = '904780';
        String docCode = 'CA80000002DB5A68_2';
        // se selecciona el objeto con data de tarjeta VISA
        LP_DataFactory.WrapperLeadData ldata = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.tipo_tarjeta == LP_DataFactory.PRV_ACC_TARJETA_VISA ? LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL : LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL;
        // se genera la data del Lead en memoria
        Lead objLead = new Lead();
        objLead.LP_Rut__c = ldata.rut;
        objLead.FirstName = ldata.nombre;
        objLead.LastName = ldata.primerApellido;
        objLead.Email = ldata.email;
        objLead.MobilePhone = ldata.mobilePhone;
        // se inicia el test
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepSixController.validateOTPCode(objLead, otpCode);
        System.assertEquals(response, docCode, 'It´s Worked!');
        Test.stopTest();
    }

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void validateOTPCodeWithTLP_Test() {
        // se inicializa los endpoint
        List<String> endPoint = new List<String>();
        endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
        endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'CreacionDeDocumentos'));
        // se inicializa los mock
        List<String> resBody = new List<String>();
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
        resBody.add(LP_RestMock_TEST.PBC_STR_JSON_CREATE_DOC9);
        // codigo incluido en el recurso estatico
        String otpCode = '904780';
        String docCode = 'CA80000002DB5AB9_2';
        // se selecciona el objeto con data de tarjeta VISA
        LP_DataFactory.WrapperLeadData ldata = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.tipo_tarjeta == LP_DataFactory.PRV_ACC_TARJETA_TLP ? LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL : LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL;
        // se genera la data del Lead en memoria
        Lead objLead = new Lead();
        objLead.LP_Rut__c = ldata.rut;
        objLead.FirstName = ldata.nombre;
        objLead.LastName = ldata.primerApellido;
        objLead.Email = ldata.email;
        objLead.MobilePhone = LP_DataFactory.clearPhonePrefix(ldata.mobilePhone);
        // se inicia el test
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepSixController.validateOTPCode(objLead, otpCode);
        System.assertEquals(response, docCode, 'It´s Worked!');
        Test.stopTest();
    }

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void validateDocumentsLeadWithNOAcc_Test() {
         // se inicializa los endpoint
         List<String> endPoint = new List<String>();
         endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
         endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ObtencionDeDocumentos'));
         endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE967'));
         // se inicializa los mock
         List<String> resBody = new List<String>();
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_GET_DOC);
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_SIGN_DOC);
        // codigo incluido en el recurso estatico
        String otpCode = '904780';
        // se genera la data del Lead en memoria
        Lead objLead = new Lead();
        objLead.LP_Rut__c = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.rut;
        objLead.FirstName = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.nombre;
        objLead.LastName = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.primerApellido;
        objLead.Email = LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.email;
        objLead.MobilePhone = LP_DataFactory.clearPhonePrefix(LP_DataFactory.PRV_ONB_LEAD_WITHNO_CLIENT_CL.mobilePhone);
        // se inicia el test
        Test.startTest();
        LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
        String response = LP_OnboardingStepSixController.validateDocuments(objLead, otpCode);
        System.assertEquals(response, LP_OnBoardingUtility.PBC_STR_STEPSEVEN, 'It´s Worked!');
        Test.stopTest();
    }

    /**
    *  @Description: Test the call method
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        23/07/2021
    */
    @isTest 
    static void validateDocumentsLeadWithAcc_Test() {
         // se inicializa los endpoint
         List<String> endPoint = new List<String>();
         endPoint.add(LP_RestMock_TEST.PVR_MAP_PATH.get(LP_RestMock_TEST.PBC_PATH_TOKEN).LP_RutaURL__c);
         endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'ObtencionDeDocumentos'));
         endPoint.add(LP_RestMock_TEST.getEndPoint('URL_Base_Integracion', 'AOE967'));
         // se inicializa los mock
         List<String> resBody = new List<String>();
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_TOKEN);
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_GET_DOC);
         resBody.add(LP_RestMock_TEST.PBC_STR_JSON_SIGN_DOC);
         // codigo incluido en el recurso estatico
         String otpCode = '904780';
         // se genera la data del Lead en memoria
         Lead objLead = new Lead();
         objLead.LP_Rut__c = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.rut;
         objLead.FirstName = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.nombre;
         objLead.LastName = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.primerApellido;
         objLead.Email = LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.email;
         objLead.MobilePhone = LP_DataFactory.clearPhonePrefix(LP_DataFactory.PRV_ONB_LEAD_WITH_CLIENT_CL.mobilePhone);
         // se inicia el test
         Test.startTest();
         LP_RestMock_TEST.getMultimock(endPoint, resBody, 200);
         String response = LP_OnboardingStepSixController.validateDocuments(objLead, otpCode);
         System.assertEquals(response, LP_OnBoardingUtility.PBC_STR_STEPSEVEN, 'It´s Worked!');
         Test.stopTest();    }
}