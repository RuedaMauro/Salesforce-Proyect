/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 10/06/2021
Description  : Class for Biometric Ident Check Service mapping
History      : PCRM-15 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			10/06/2021		initial version
********************************************************************************/
public with sharing class LP_MAPJSONIdentCheckValidation {
    private SObject record;
    private String scanreference;

    /**
    *  @Description: Constructor Method.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public LP_MAPJSONIdentCheckValidation(SObject record, String scanreference) {
        this.record = record;
        this.scanreference = scanreference;
    }

    /**
    *  @Description: Mapping method.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public LP_JSONIdentCheckRequest mapping(){
        Lead leadRecord = (Lead)this.record;
        LP_JSONIdentCheckRequest objIdentChk = new LP_JSONIdentCheckRequest();

        objIdentChk.header = new LP_JSONHeaderRequest();
        objIdentChk.header.country = 'CL';
        objIdentChk.header.commerce = 'RF';
        objIdentChk.header.channel = 'CRM';

        objIdentChk.body = new LP_JSONIdentCheckRequest.Body();
        objIdentChk.body.rut = Integer.valueOf(leadRecord.LP_Rut__c.split('-')[0]);
        objIdentChk.body.dv = String.valueOf(leadRecord.LP_Rut__c.split('-')[1]);
        objIdentChk.body.scanReference = (this.scanreference != null) ? this.scanreference : '';

        return objIdentChk;
    }

    /**
    *  @Description: Call service with token.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public string call(){

        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ValidacionIdentCheck');
        String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }
}
