/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 28/07/2021
Description  : API AOE-221 Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			28/07/2021		initial version
********************************************************************************/
public with sharing class LP_Aoe221Call {

    private String rut;
    private Integer cuotas;
    private String tasa;
    private String dias_mora;
    private String deuda_compra;
    private String deuda_avance;
    private String deuda_avancexl;
    private String deuda_renegociar;
    private String tipofact1;
    private String tipofact3;
    
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
        INTEGRATION_ROUTE = 'AOE221';
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
    public LP_Aoe221Call(bodyRequest rq, Integer cuotas){
        this.rut = rq.rut;
        this.cuotas = cuotas;
        this.tasa = rq.tasa;
        this.dias_mora = rq.dias_mora;
        this.deuda_compra = rq.deuda_compra;
        this.deuda_avance = rq.deuda_avance;
        this.deuda_avancexl = rq.deuda_avancexl;
        this.deuda_renegociar = rq.deuda_renegociar;
        this.tipofact1 = rq.tipofact1;
        this.tipofact3 = rq.tipofact3;
    }

    /**
    *  @Description: API-279 json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    private LP_JSONAoe221Request mapping() {
        LP_JSONAoe221Request otp = new LP_JSONAoe221Request();
        otp.body = new LP_JSONAoe221Request.Body();
        otp.body.rut = rut;
        otp.body.tasa = tasa;
        otp.body.dias_mora = dias_mora;
        otp.body.deuda_compra = deuda_compra;
        otp.body.deuda_avance = deuda_avance;
        otp.body.deuda_avancexl = deuda_avancexl;
        otp.body.deuda_renegociar = deuda_renegociar;
        otp.body.tipofact1 = tipofact1;
        otp.body.tipofact3 = tipofact3;
        otp.body.desfase = '0';
        otp.body.tipo_operacion = 'S';
        otp.body.dia_pago = '1';
        otp.body.cuotas = cuotas;
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
    
    public Class bodyRequest{
        public String rut;
		public String tasa;
		public String dias_mora;
		public String deuda_compra;
        public String deuda_avance;
		public String deuda_avancexl;
		public String deuda_renegociar;
		public String tipofact1;
        public String tipofact3;
    }

}