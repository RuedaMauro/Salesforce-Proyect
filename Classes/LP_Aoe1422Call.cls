/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : API AOE-279 Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_Aoe1422Call {

    private Integer rut;
    private String dv;

    /**
    *  @Description: Constructor
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021         
    */
    public LP_Aoe1422Call(Integer rut, String dv){
        this.rut = rut;
        this.dv = dv;
    }

    /**
    *  @Description: API-279 json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    private LP_JSONAoe1422Request mapping() {
        LP_JSONAoe1422Request otp = new LP_JSONAoe1422Request();
        otp.body = new LP_JSONAoe1422Request.Body();
        otp.body.rut = Integer.valueOf(rut);
        otp.body.dv = dv;
        otp.body.channel = 'GEN';
        otp.header = new LP_JSONHeaderRequest();
        otp.header.commerce = 'RF';
        otp.header.country = 'CL';
        otp.header.channel = 'CRM';
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
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'AOE1422');
        return objClass.callServiceWithTokenPrivateSite(setConf, JSON.serialize(mapping(), true));
    }

}