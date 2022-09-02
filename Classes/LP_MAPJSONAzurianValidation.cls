/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 02/06/2021
Description  : Class for Azurian Service mapping (init, consult and validate)
History      : PCRM-15 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			02/06/2021		initial version
********************************************************************************/

public with sharing class LP_MAPJSONAzurianValidation {
    
    private SObject record;
    private String action;
    private String scanreference;
    private String civilRegistryAction;
    private String guid;
    private String urlEnv;
    private String administrationClientKey;
    /**
    *  @Description: Constructor Method.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        03/06/2021
    */
    public LP_MAPJSONAzurianValidation(SObject record, Map<String,String> params) {
        
        this.action = params.get('action');
        this.civilRegistryAction = (params.get('action') == 'init_azurian') ? 'VALIDATE' : 'IGNORE';
        this.guid = params.get('guid');
        this.record = record;
        this.scanreference = params.get('scanreference');
        this.urlEnv = params.get('url') + '/OnboardingTarjetaLaPolar/s/?g='; 
        LP_RutaIntegracion__mdt objPathInt = LP_RestConnectionUtility.PVR_MAP_PATH.get('AzurianAdministrationClientKey'); 
        this.administrationClientKey = objPathInt.LP_Cabeceras__c;
    }

    /**
    *  @Description: Mapping method.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        03/06/2021
    */
    public LP_JSONAzurianRequest mapping(){
        Lead leadRecord = (Lead)this.record;
        LP_JSONAzurianRequest objAzurian = new LP_JSONAzurianRequest();        
        objAzurian.body = new LP_JSONAzurianRequest.Body();

        objAzurian.body.NumRut = Integer.valueOf(leadRecord.LP_Rut__c.split('-')[0]); 
        objAzurian.body.DigRut = String.valueOf(leadRecord.LP_Rut__c.split('-')[1]); 
        objAzurian.body.Action = this.action;
        objAzurian.body.j_customerInternalReference = 'LaPolar';
        objAzurian.body.j_UserReference = 'LP';
        objAzurian.body.j_SuccessUrl = this.urlEnv+this.guid;
        objAzurian.body.j_ErrorUrl = this.urlEnv+'error';
        objAzurian.body.j_CallbackUrl = this.urlEnv+this.guid;
        objAzurian.body.j_reportingCriteria = 'LP';
        objAzurian.body.j_workflowId = 201;
        objAzurian.body.j_Locale = 'es';
        objAzurian.body.j_Azurian_administrationClientKey = this.administrationClientKey;
        objAzurian.body.j_Azurian_civilRegistryAction = this.civilRegistryAction;
        objAzurian.body.j_Azurian_civilRegistryValid = '';
        objAzurian.body.j_Azurian_civilRegistryDate = '';
        objAzurian.body.j_Azurian_scanreference = (this.scanreference != null) ? this.scanreference : '';
        objAzurian.body.j_Get_scanreference = (this.scanreference != null) ? this.scanreference : '';
        objAzurian.body.j_Azurian_civilRegistryRawResponse = '';

        objAzurian.header = new LP_JSONHeaderRequest();
        objAzurian.header.country = 'CL';
        objAzurian.header.commerce = 'RF';
        objAzurian.header.channel = 'CRM';
        
        return objAzurian;

    }
    
    /**
    *  @Description: Call service with token.
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        03/06/2021
    */
    public string call(){

        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ValidacionAzurian');
        String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }
}