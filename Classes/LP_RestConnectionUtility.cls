/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 08/04/2021
Description  : Class with utility methods for Rest Connection
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            08/04/2021		   	Created Class
********************************************************************************/
public virtual class LP_RestConnectionUtility {

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    public static final Map<String, LP_ServicioIntegracion__mdt> PVR_MAP_SERVICE{get; private set;}
    public static final Map<String, LP_RutaIntegracion__mdt> PVR_MAP_PATH{get; private set;}
    private static final String PVR_STR_COLON;
    private static final String PVR_STR_SMCOLON;
    private static final String PVR_STR_DASH;


    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        PVR_MAP_SERVICE = fillMapService();
        PVR_MAP_PATH = fillMapPath();
        PVR_STR_COLON = ':';
        PVR_STR_SMCOLON = ';';
        PVR_STR_DASH = '-';
    }

    /**
    *  @Description: Fill map service, service used in the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        07/05/2021
    */    
    private static Map<String, LP_ServicioIntegracion__mdt> fillMapService() {
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
    private static Map<String, LP_RutaIntegracion__mdt> fillMapPath() {
        Map<String, LP_RutaIntegracion__mdt> objMap = new Map<String, LP_RutaIntegracion__mdt>();
        for (LP_RutaIntegracion__mdt pth : [SELECT DeveloperName, MasterLabel, LP_RutaURL__c, LP_Metodo__c, LP_Cabeceras__c FROM LP_RutaIntegracion__mdt LIMIT 100]) {
            objMap.put(pth.DeveloperName, pth);
        }
        return objMap;
    }

    /**
    *  @Description: Fill map header, headers used in the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    protected Map<String, String> fillMapHeader(String vrb) {
        Map<String, String>  str = new Map<String, String>();
        Map<String, String>  stcMap = new Map<String, String>();
        if (!String.isBlank(vrb)) {
            String[] splitStr = vrb.Split(PVR_STR_SMCOLON);
            for (String c : splitStr) {
                if (stcMap.containsKey(c.Split(PVR_STR_COLON)[0])) {
                	str.put(c.Split(PVR_STR_COLON)[0], stcMap.get(c.Split(PVR_STR_COLON)[0])); 
                } else {
                    str.put(c.Split(PVR_STR_COLON)[0], c.Split(PVR_STR_COLON)[1]);
                }
            }
        }
        return str;
    }

    /**
    *  @Description: Check if the token duration time is valid
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    protected Boolean isValidToken(Datetime cachedValid) {
        if (cachedValid != null) {
            decimal hours = decimal.valueof(((dateTime.now().getTime() - cachedValid.getTime())/(60*60))/1000);
            return hours < 8 ? true : false;
        }
        return false;
    }

    /**
    *  @Description: Get GUID, generates a transaction identifier when invoking a service
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/05/2021
    */
    public static String getGUID() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ PVR_STR_DASH + h.SubString(8,12) + PVR_STR_DASH + h.SubString(12,16) + PVR_STR_DASH + h.SubString(16,20) + PVR_STR_DASH + h.substring(20);
        return guid;
    }
    
}