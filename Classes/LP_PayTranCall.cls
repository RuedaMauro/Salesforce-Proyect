/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 29/07/2021
Description  : API Pay Transfer Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			29/06/2021		initial version
********************************************************************************/
public with sharing class LP_PayTranCall {
    
    public String transactionId;
    public Integer amount;
	public String currency_x;
    public LP_JSONPayTranRequest.Customer customer;
    public List<LP_JSONPayTranRequest.Consumptions> consumptions;
	public String usingPaymentGateway;
    public String returnUserToURL;
    
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
        INTEGRATION_ROUTE = 'AOE215';
        RQ_BODY_CHANNEL = 'GEN';
        CONFIG_HEADER = 'header';
        CONFIG_PATH = 'path';
        CONFIG_QUERY = 'query';
    }


    /**
    *  @Description: Constructor
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021         
    */
    public LP_PayTranCall(LP_JSONPayTranRequest rq){
        this.transactionId = rq.transactionId;
        this.amount = rq.amount;
        this.currency_x = rq.currency_x;
        this.customer = rq.customer;
        this.consumptions = rq.consumptions;
        this.usingPaymentGateway = rq.usingPaymentGateway;
        this.returnUserToURL = rq.returnUserToURL;
    }

     /**
    *  @Description: API-207 json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021  
    */
    private LP_JSONPayTranRequest mapping() {
        LP_JSONPayTranRequest otp = new LP_JSONPayTranRequest();
        otp.transactionId = this.transactionId;
        otp.amount = this.amount;
        otp.currency_x = this.currency_x;
        otp.customer = this.customer;
        otp.consumptions = this.consumptions;
        otp.usingPaymentGateway = this.usingPaymentGateway;
        otp.returnUserToURL = this.returnUserToURL;
        return otp;
    }

     /**
    *  @Description: API 207 Service Call
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021  
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