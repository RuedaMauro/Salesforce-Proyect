/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : Verifies if Client is a credit client
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_GetDocList {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    
    private static final String MSG_DOC_NOT_FOUND;
    
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        MSG_DOC_NOT_FOUND = 'Documento no encontrado';
    }
    
    /**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response getDocList(String rut){
        LP_Response rp = new LP_Response();
        LP_Aoe151Call call = new LP_Aoe151Call(Integer.valueOf(rut));
        rp.rut = Integer.valueOf(rut);
        String rsp = call.call().getBody();
        LP_JSONAoe151Response aux = (LP_JSONAoe151Response)JSON.deserialize(rsp , LP_JSONAoe151Response.class);
        rp.signedDocuments = new List<LP_Response.signedDoc>();
        for(LP_JSONAoe151Response.items a: aux.items){
            LP_Response.signedDoc sd = new LP_Response.signedDoc();
            sd.id = a.numero;
            sd.name = a.nomdoc;
            sd.docdate = a.fecha;
            rp.signedDocuments.add(sd);
        }
        return rp;
    }
}