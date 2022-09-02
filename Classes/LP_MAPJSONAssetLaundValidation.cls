/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 18/05/2021
Description  : Class for Asset Laundering validation mapping
History      : PCRM -12
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			18/05/2021		initial version
********************************************************************************/
public with sharing class LP_MAPJSONAssetLaundValidation {

    private SObject record;
    private String nac;

    /**
    *  @Description: Constructor
    *  @Author:      Eilhert Andrade A, Deloitte, eandradea@deloitte.com
    *  @Date:        18/05/2021         
    */
    public LP_MAPJSONAssetLaundValidation(SObject rec, String nac) {
        this.record = rec;
        this.nac = nac;
    }

    /**
    *  @Description: OTP validation json mapping
    *  @Author:      Eilhert Andrade A, Deloitte, eandradea@deloitte.com
    *  @Date:        18/05/2021
    */
    public LP_JSONAssetLaundRequest mapping(){
        Lead leadRecord = (Lead)this.record;
        LP_JSONAssetLaundRequest objAssetL = new LP_JSONAssetLaundRequest();        
        objAssetL.body = new LP_JSONAssetLaundRequest.Body();

        objAssetL.body.NUMRUT = Integer.valueOf(leadRecord.LP_Rut__c.split('-')[0]); 
        objAssetL.body.DIGRUT = String.valueOf(leadRecord.LP_Rut__c.split('-')[1]); 
        objAssetL.body.nombres = leadRecord.FirstName;
        objAssetL.body.apellidos = leadRecord.LastName + ' ' + leadRecord.LP_ApellidoMaterno__c;
        objAssetL.body.nacionalidad = this.nac;
        objAssetL.body.tipo = '0';
        objAssetL.body.estatus = '0';
        objAssetL.body.autorizado = '8';
        objAssetL.body.id_emp = 0;
        objAssetL.body.source = '0';
        objAssetL.body.id_request = 0;

        objAssetL.header = new LP_JSONHeaderRequest();
        objAssetL.header.country = 'CL';
        objAssetL.header.commerce = 'RF';
        objAssetL.header.channel = 'CRM';
        
        return objAssetL;
    }

    /**
    *  @Description: Call Asset Laundring service
    *  @Author:      Eilhert Andrade A, Deloitte, eandradea@deloitte.com
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
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'LavadoActivos');
        String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }

}