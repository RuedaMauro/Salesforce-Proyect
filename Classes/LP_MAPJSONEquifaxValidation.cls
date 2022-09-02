/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 18/05/2021
Description  : Class for JSON Equifax validation mapping
History      : PCRM-13
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Alan Sanhueza Carrasco	     ASC
Nelson Lepiqueo Lepiqueo     NLL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ASC-NLL     18/05/2021		  initial version
********************************************************************************/
public with sharing class LP_MAPJSONEquifaxValidation {
	
    private static final String PRV_URL_BASEURL;
    private static final String PVR_SRV_EQUIFAX;
    private SObject record;

    static {
        PRV_URL_BASEURL = 'URL_Base_Integracion';
        PVR_SRV_EQUIFAX = 'ValidacionEQUIFAX';     
    }

    public LP_MAPJSONEquifaxValidation(SObject rec) {
        this.record = rec;
    }
	
    /**
    *  @Description: Constructor
    *  @Autor:       ASC-NLL, Deloitte, asanhuezac@deloitte.com
    *  @Date:        18/05/2021
    */
    public LP_JSONEquifaxRequest mapping(){
		Lead leadRecord = (Lead)this.record;
        LP_JSONEquifaxRequest reqEquifax = new LP_JSONEquifaxRequest();
        reqEquifax.body = new LP_JSONEquifaxRequest.Body();
        
		reqEquifax.body.rut = Integer.valueOf(leadRecord.LP_Rut__c.split('-')[0]);
		reqEquifax.body.dig = String.valueOf(leadRecord.LP_Rut__c.split('-')[1]); 
		reqEquifax.body.nSerie = '';
		//reqEquifax.body.trans = '';
		reqEquifax.body.terminal = '';
		reqEquifax.body.secuence = '';
		reqEquifax.body.local = '0';
        
	    reqEquifax.header = new LP_JSONHeaderRequest();
		reqEquifax.header.country = 'CL';
		reqEquifax.header.commerce = 'RF';
		reqEquifax.header.channel = 'CRM';
        
        return reqEquifax;
    }
	
    /**
    *  @Description: Equifax validation json mapping
    *  @Autor:       ASC-NLL, Deloitte, asanhuezac@deloitte.com
    *  @Date:        18/05/2021
    */
    public String call(){
        
		Map<String, String> pathParam = new Map<String, String>();
		Map<String, String> mapHeader = new Map<String, String>();
		Map<String, String> mapQuery = new Map<String, String>();
		Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
		setConf.put('header', mapHeader);
		setConf.put('path', pathParam);
		setConf.put('query', mapQuery);
		
		LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth(PRV_URL_BASEURL, PVR_SRV_EQUIFAX);
		String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }
}