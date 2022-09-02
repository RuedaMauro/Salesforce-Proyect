/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : API AOE-1233 Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_Aoe1233Call {
    private Integer rut;
    private String dv;
    private String pan;
    
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
    private static final String RQ_BODY_CHANNEL;
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
        INTEGRATION_ROUTE = 'AOE1233';
        RQ_BODY_CHANNEL = 'GEN';
        CONFIG_HEADER = 'header';
        CONFIG_PATH = 'path';
        CONFIG_QUERY = 'query';
    }

    /**
    *  @Description: Constructor
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021         
    */
    public LP_Aoe1233Call(Integer rut, String dv, String pan){
        this.rut = rut;
        this.dv = dv;
        this.pan = pan;
    }
    
	/**
    *  @Description: API-646 json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    private LP_JSONAoe1233Request mapping() {
        LP_JSONAoe1233Request otp = new LP_JSONAoe1233Request();
        otp.body = new LP_JSONAoe1233Request.Body();
        otp.body.rut = Integer.valueOf(rut);
        otp.body.dv = dv;
        otp.body.pan = pan;
        otp.header = new LP_JSONHeaderRequest();
        otp.header.commerce = RQ_HEADER_COMMERCE;
        otp.header.country = RQ_HEADER_COUNTRY;
        otp.header.channel = RQ_HEADER_CHANNEL;
        return otp;
    }

    /**
    *  @Description: API 279 Service Call
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