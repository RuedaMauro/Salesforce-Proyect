/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : API AOE-577 Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_Aoe577Call {

    Integer rut;
    String dv;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String RQ_HEADER_COMMERCE;
    private static final String RQ_HEADER_COUNTRY;
    private static final String RQ_HEADER_CHANNEL;
    private static final String INTEGRATION_BASE;
    private static final String INTEGRATION_ROUTE;
    private static final String CONFIG_HEADER;
    private static final String CONFIG_PATH;
    private static final String CONFIG_QUERY;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        RQ_HEADER_COMMERCE = 'RF';
        RQ_HEADER_COUNTRY = 'CL';
        RQ_HEADER_CHANNEL = 'CRM';
        INTEGRATION_BASE = 'URL_Base_Integracion';
        INTEGRATION_ROUTE = 'AOE577';
        CONFIG_HEADER = 'header';
        CONFIG_PATH = 'path';
        CONFIG_QUERY = 'query';
    }

    /**
    *  @Description: Constructor
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021         
    */
    public LP_Aoe577Call(Integer rut, String dv){
        this.rut = rut;
        this.dv = dv;
    }
    

    /**
    *  @Description: API-577 json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    private LP_JSONAoe577Request mapping() {
        LP_JSONAoe577Request otp = new LP_JSONAoe577Request();
        otp.body = new LP_JSONAoe577Request.Body();
        otp.body.rut = this.rut;
        otp.body.dv = this.dv;
        otp.header = new LP_JSONHeaderRequest();
        otp.header.commerce = RQ_HEADER_COMMERCE;
        otp.header.country = RQ_HEADER_COUNTRY;
        otp.header.channel = RQ_HEADER_CHANNEL;
        return otp;
    }

    /**
    *  @Description: API 577 Service Call
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    public HttpResponse call() {
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put(CONFIG_HEADER, mapHeader);
        setConf.put(CONFIG_PATH, pathParam);
        setConf.put(CONFIG_QUERY, mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth(INTEGRATION_BASE, INTEGRATION_ROUTE);
        return objClass.callServiceWithTokenPrivateSite(setConf, JSON.serialize(mapping(), true));
    }

  
}