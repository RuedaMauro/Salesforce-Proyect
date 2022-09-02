/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Class responsible to the Rest Mock
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			17/05/2021		initial version
********************************************************************************/
@isTest
global class LP_RestMock_TEST implements HttpCalloutMock{
        
    public String service;
    public String contentType;
    public Integer statusCode;
    public String json;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    public static final String PBC_PATH_TOKEN;
    public static final String PBC_STR_CONTENTTYPE;
    public static final String PBC_STR_APPJSON;
    public static final String PBC_STR_JSON_APIGOOGLE_AUTOCOMPLETE;
    public static final String PBC_STR_JSON_APIGOOGLE_DETAIL;
    public static final String PBC_STR_JSON_BECLEVER;
    public static final String PBC_STR_JSON_EQUIFAX;
    public static final String PBC_STR_JSON_OTP;
    public static final String PBC_STR_JSON_OTP_BYPHONE;
    public static final String PBC_STR_JSON_CREATE_DOC8;
    public static final String PBC_STR_JSON_CREATE_DOC9;
    public static final String PBC_STR_JSON_GET_DOC;
    public static final String PBC_STR_JSON_SIGN_DOC;
    public static final String PBC_STR_JSON_TOKEN;
    public static final Map<String, LP_ServicioIntegracion__mdt> PVR_MAP_SERVICE{get; private set;}
    public static final Map<String, LP_RutaIntegracion__mdt> PVR_MAP_PATH{get; private set;}
    public static final String PBC_STR_JSON_ASL;
    public static final String PBC_STR_JSON_AZINI;
    public static final String PBC_STR_JSON_AZCON;
    public static final String PBC_STR_JSON_IDCHK;
    public static final String PBC_STR_JSON_AZVLD; 
	public static final String PBC_STR_JSON_AOE577;
    public static final String PBC_STR_JSON_AOE577_NOCREDIT;
    public static final String PBC_STR_JSON_AOE279;
    public static final String PBC_STR_JSON_AOE207;
    public static final String PBC_STR_JSON_AOE1172;
    public static final String PBC_STR_JSON_IA646;
    public static final String PBC_STR_JSON_IA646Dec;
    public static final String PBC_STR_JSON_IA646Nov;
    public static final String PBC_STR_JSON_IA646Sep;
    public static final String PBC_STR_JSON_IA646Oct;
    public static final String PBC_STR_JSON_AOE220;
    public static final String PBC_STR_JSON_AOE1172_404;
    public static final String PBC_STR_JSON_AOE1172_01;
    public static final String PBC_STR_JSON_AOE1172_08;
    public static final String PBC_STR_JSON_IA995;
    public static final String PBC_PATH_TOKEN_Sitio_Privado;
    public static final String PBC_STR_JSON_AOE212;
    public static final String PBC_STR_JSON_AOE189;
    public static final String PBC_STR_JSON_AOE1233;
    public static final String PBC_STR_JSON_AOE68;
    public static final String PBC_STR_JSON_AOE966;
    public static final String PBC_STR_JSON_AOE224;
    public static final String PBC_STR_JSON_AOE225;
    public static final String PBC_STR_JSON_AOE214;
    public static final String PBC_STR_JSON_AOE215;
    public static final String PBC_STR_JSON_AOE231;
    public static final String PBC_STR_JSON_AOE231_NOV;
    public static final String PBC_STR_JSON_PayTran;
    public static final String PBC_STR_JSON_AOE221;
    public static final String PBC_STR_JSON_AOE103;
    public static final String PBC_STR_JSON_AOE151;
    public static final String PBC_STR_JSON_AOE1422;
    public static final String PBC_STR_JSON_AOE214_NOV;
    public static final String PBC_STR_JSON_DOCONE;
    public static final String PBC_STR_JSON_DOCTWO;
    public static final String PBC_STR_JSON_DOCTHREE;
    public static final String PBC_STR_JSON_DOCFOUR;
    public static final String PBC_STR_JSON_GETDOCONE;
    public static final String PBC_STR_JSON_APILOGIN;
    							
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    static {
        PVR_MAP_SERVICE = fillMapService();
        PVR_MAP_PATH = fillMapPath();
        PBC_STR_CONTENTTYPE = 'Content-Type';
        PBC_STR_APPJSON = 'application/json';
        PBC_PATH_TOKEN = 'AutenticacionAPIGEE';
        PBC_STR_JSON_OTP = 'LP_JSONValidacionOTP';
        PBC_STR_JSON_OTP_BYPHONE = 'LP_JSONValidationOTPByPhone';
        PBC_STR_JSON_CREATE_DOC8 = 'LP_JSONValidationCreateDoc_8VISA';
        PBC_STR_JSON_CREATE_DOC9 = 'LP_JSONValidationCreateDoc_9TLP';
        PBC_STR_JSON_GET_DOC = 'LP_JSONValidationGETContract';
        PBC_STR_JSON_SIGN_DOC = 'LP_JSONValidationSignContract';
        PBC_STR_JSON_EQUIFAX = 'LP_JSONValidacionEquifax';
        PBC_STR_JSON_BECLEVER ='LP_JSONValidacionBeClever';
        PBC_STR_JSON_TOKEN = 'LP_JSONToken';
        PBC_STR_JSON_ASL = 'LP_JSONValidationAssetLaundering';
        PBC_STR_JSON_AZINI = 'LP_JSONValidationAzurianInit';
        PBC_STR_JSON_AZCON = 'LP_JSONValidationAzurianConsulta';
        PBC_STR_JSON_IDCHK = 'LP_JSONValidationIdentCheck';
        PBC_STR_JSON_AZVLD = 'LP_JSONValidationAzurianValida';
        PBC_STR_JSON_APIGOOGLE_AUTOCOMPLETE = 'LP_JSONValidationApiGooAutocomplete';
        PBC_STR_JSON_APIGOOGLE_DETAIL = 'LP_JSONValidationApiGooDetail';
        PBC_STR_JSON_IA646 = 'LP_IA646_Response';
        PBC_STR_JSON_AOE1172 = 'LP_AOE1172_Response';
        PBC_STR_JSON_AOE207 = 'LP_AOE207_Response';
        PBC_STR_JSON_PayTran = 'LP_PayTran_Response';
        PBC_STR_JSON_AOE279 = 'LP_AOE279_Response';
        PBC_STR_JSON_AOE577 = 'LP_AOE577_Response';
        PBC_STR_JSON_AOE577_NOCREDIT = 'LP_AOE577_Response_NoCredit';
        PBC_STR_JSON_AOE220 = 'LP_AOE220_Response';
        PBC_STR_JSON_IA995 = 'LP_IA995_Response';
        PBC_STR_JSON_IA646Dec = 'LP_IA646_ResponseDec';
        PBC_STR_JSON_IA646Nov = 'LP_IA646_ResponseNov';
        PBC_STR_JSON_IA646Oct = 'LP_IA646_ResponseOct';
        PBC_STR_JSON_IA646Sep = 'LP_IA646_ResponseSep';
        PBC_PATH_TOKEN_Sitio_Privado = 'AutenticacionAPIGEE_Sitio_Privado';
        PBC_STR_JSON_AOE1172_404 = 'LP_AOE1172_404';
        PBC_STR_JSON_AOE1172_01 = 'LP_AOE1172_01Code';
        PBC_STR_JSON_AOE1172_08 = 'LP_AOE1172_08Code';
        PBC_STR_JSON_AOE212 = 'LP_AOE212_Response';
        PBC_STR_JSON_AOE189 = 'LP_AOE189_Response';
        PBC_STR_JSON_AOE1233 = 'LP_AOE1233_Response';
        PBC_STR_JSON_AOE68 = 'LP_AOE68_Response';
        PBC_STR_JSON_AOE966 = 'LP_AOE966_Response';
        PBC_STR_JSON_AOE224 = 'LP_AOE224_Response';
        PBC_STR_JSON_AOE225 = 'LP_AOE225_Response';
        PBC_STR_JSON_AOE215 = 'LP_AOE215_Response';
        PBC_STR_JSON_AOE214 = 'LP_AOE214_Response';
        PBC_STR_JSON_AOE231 = 'LP_AOE231_Response';
        PBC_STR_JSON_AOE231_NOV = 'LP_AOE231_Response_Nov';
        PBC_STR_JSON_AOE221 = 'LP_AOE221_Response';
        PBC_STR_JSON_AOE103 = 'LP_AOE103_Response';
        PBC_STR_JSON_AOE151 = 'LP_AOE151_Response';
        PBC_STR_JSON_AOE1422 = 'LP_AOE1422_Response';
        PBC_STR_JSON_AOE214_NOV = 'LP_AOE214_Response_Nov';
        PBC_STR_JSON_DOCONE = 'LP_JSONCreacionDocumentoUno';
        PBC_STR_JSON_DOCTWO = 'LP_JSONCreacionDocumentoDos';
        PBC_STR_JSON_DOCTHREE = 'LP_JSONCreacionDocumentoTres';
        PBC_STR_JSON_DOCFOUR = 'LP_JSONCreacionDocumentoCuatro';
        PBC_STR_JSON_GETDOCONE = 'LP_JSONObtencionDocumentoUno';
        PBC_STR_JSON_APILOGIN = 'LP_JSONAccesoAPI';
    }

    /**
    *  @Description: Constructor for a rest mock
    *  @Author:      Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    global LP_RestMock_TEST(final String service, final String contentType, final Integer statusCode, final String json) {
        this.service = service;
        this.contentType = contentType;
        this.statusCode = statusCode;
        this.json = json;
    }

    /**
    *  @Description: Fill map service, service used in the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        07/05/2021
    */    
    public static Map<String, LP_ServicioIntegracion__mdt> fillMapService() {
        Map<String, LP_ServicioIntegracion__mdt> objMap = new Map<String, LP_ServicioIntegracion__mdt>();
        for (LP_ServicioIntegracion__mdt srv : [SELECT DeveloperName, MasterLabel, LP_URLBase__c,  LP_ClaveDeSitio__c, LP_ClaveSecreta__c FROM LP_ServicioIntegracion__mdt LIMIT 100]) {
            objMap.put(srv.DeveloperName, srv);
        }
        return objMap;
    }

    /**
    *  @Description: Fill map path, path used in the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        07/05/2021
    */    
    public static Map<String, LP_RutaIntegracion__mdt> fillMapPath() {
        Map<String, LP_RutaIntegracion__mdt> objMap = new Map<String, LP_RutaIntegracion__mdt>();
        for (LP_RutaIntegracion__mdt pth : [SELECT DeveloperName, MasterLabel, LP_RutaURL__c, LP_Metodo__c, LP_Cabeceras__c FROM LP_RutaIntegracion__mdt LIMIT 100]) {
            objMap.put(pth.DeveloperName, pth);
        }
        return objMap;
    }

    /**
    *  @Description: Consult the parameters of the services
    *  @Author:      Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        07/05/2021
    */
    public static String getEndPoint(String nameService, String namePath) {
        return PVR_MAP_SERVICE.get(nameService).LP_URLBase__c + PVR_MAP_PATH.get(namePath).LP_RutaURL__c;
    }

    /**
    *  @Description: Raises the response to a single service call
    *  @Author:      Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader(PBC_STR_CONTENTTYPE, contentType);
        response.setBody(json);
        response.setStatusCode(statusCode);
        return response;
    }
    
    /**
    *  @Description: Raise the answer to several service calls
    *  @Author:      Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    global static void getMultimock(List<String> listEndpoints,List<String> listBody, Integer statusCode) {
        
        MultiStaticResourceCalloutMock multimock = new MultiStaticResourceCalloutMock();
        
        for (Integer i = 0; i<listEndpoints.size() ; i++) {
            multimock.setStaticResource(listEndpoints[i], listBody[i]);
        }
        multimock.setStatusCode(statusCode);
        multimock.setHeader(PBC_STR_CONTENTTYPE, PBC_STR_APPJSON);
        Test.setMock(HttpCalloutMock.class, multimock);
    }
}