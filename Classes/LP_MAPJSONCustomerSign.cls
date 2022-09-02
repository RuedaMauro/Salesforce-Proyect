/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 06/07/2021
Description  : Class for Customer Sign mapping
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye			RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			06/07/2021		initial version
********************************************************************************/
public with sharing class LP_MAPJSONCustomerSign {
    private Lead objLead;
    List<Map<String, String>> paramList;  

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        22/07/2021
    */
    public static final String PVR_PARAM_NUMERO;
    public static final String PVR_PARAM_AUDIT;
    public static final String PVR_PARAM_CODE;
    public static final String PVR_PARAM_SESSION;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        22/07/2021
    */
    static {
        PVR_PARAM_NUMERO = 'numero';
        PVR_PARAM_AUDIT = 'audit';
        PVR_PARAM_CODE = 'code';
        PVR_PARAM_SESSION = 'session_id';
    }

    /**
    *  @Description: Constructor
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/07/2021      
    */
    public LP_MAPJSONCustomerSign(Lead objLead, List<Map<String, String>> paramList) {
        this.objLead = objLead;
        this.paramList = paramList;
    }

    /**
    *  @Description: Customer Sign json mapping
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/07/2021   
    */
    private LP_JSONCustomerSignRequest mapping(Map<String, String> parameter) {
        LP_JSONCustomerSignRequest custSignRequest = new LP_JSONCustomerSignRequest();
        custSignRequest.body = new LP_JSONCustomerSignRequest.Body();
        custSignRequest.body.user_rut = integer.valueof(objLead.LP_Rut__c?.left(objLead.LP_Rut__c?.length() - 2));
        custSignRequest.body.digito = objLead.LP_Rut__c?.right(1);
        custSignRequest.body.nombres = objLead.FirstName;
        custSignRequest.body.apellidos = objLead.LastName;
        custSignRequest.body.user_role = objLead.LP_Rut__c;
        custSignRequest.body.tipo   = '9'; //9=Contract
        custSignRequest.body.user_institution = 'LAPOLAR'; // Campo fijo de institución
        custSignRequest.body.local = 0; // campo fijo (definido para onboarding)
        custSignRequest.body.numven = 11111111; // número de rut del vendedor (campo fijo para onboarding)
        custSignRequest.body.digven = 1; // número de rut del vendedor (campo fijo para onboarding)
        custSignRequest.body.numero = parameter.get(PVR_PARAM_NUMERO); // parametro dependiente del documento
        custSignRequest.body.audit = parameter.get(PVR_PARAM_AUDIT); // parametro dependiente del documento
        custSignRequest.body.code = parameter.get(PVR_PARAM_CODE); // parametro dependiente del documento
        custSignRequest.body.session_id = parameter.get(PVR_PARAM_SESSION); // parametro dependiente del documento

        custSignRequest.header = new LP_JSONHeaderRequest();
        custSignRequest.header.commerce = 'RF';
        custSignRequest.header.country = 'CL';
        custSignRequest.header.channel = 'CRM';
        return custSignRequest;
    }
    
    /**
    *  @Description: Call to service
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/07/2021   
    */
    public List<String> call() {
        List<String> responseList = new List<String>();
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'AOE967');
        for (Map<String,String> parameter : this.paramList) {
            responseList.add(objClass.callServiceWithToken(setConf, JSON.serialize(mapping(parameter), true)).getBody());
        }
        return responseList;
    }
}