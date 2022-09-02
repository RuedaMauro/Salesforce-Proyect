/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : Class for Customer Contract Create Service mapping
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva       	ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			08/07/2021		initial version
********************************************************************************/
public inherited sharing class LP_MAPJSONCustomerGetDocuments {

    private String code;

    public LP_MAPJSONCustomerGetDocuments(){

    }

    public LP_MAPJSONCustomerGetDocuments(String code){
        this.code = code;
    }

    /**
    *  @Description: Mapping method.
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private  LP_JSONCustomerGetDocumentsRequest mapping(){
        LP_JSONCustomerGetDocumentsRequest doc = new LP_JSONCustomerGetDocumentsRequest();
        doc.header = new LP_JSONHeaderRequest();
        doc.header.country = 'CL';
        doc.header.commerce = 'RF';
        doc.header.channel = 'Omnichannel';
        doc.body = new LP_JSONCustomerGetDocumentsRequest.Body();
        doc.body.code = code;
        doc.body.institution = 'LAPOLAR';
        doc.body.extra = 'signers';
        return doc;
    }

    /**
    *  @Description: Call service with token.
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    public string call(){
        String rsp;
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ObtencionDeDocumentos');
        rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }

    /**
    *  @Description: Call service with token for a list of documents codes
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        22/07/2021
    */
    public List<String> multipleCall(List<String> codeList){
        List<String> rsp = new List<String>();
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ObtencionDeDocumentos');
        for (String codeDoc : codeList) {
            this.code = codeDoc;
            String responseString = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
            rsp.add(responseString);
        }
        
        return rsp;
    }
}
