/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 03/08/2021
Description  : Get doc from eecc from Client
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			03/08/2021		initial version
********************************************************************************/
public with sharing class LP_GetDoc {
    
    /**
*  @Description: Gets Documents to show in the PDF among other relevant client data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
	@AuraEnabled
    public static LP_Response getDoc(String rut, String pan, String fecemi){
        LP_Response rp = new LP_Response();
        String lpan = pan.substring(0,16);
        LP_Aoe215Call call = new LP_Aoe215Call(rut, lpan, fecemi);
        String rsp = call.call().getBody();
        LP_JSONAoe215Response aux = (LP_JSONAoe215Response)JSON.deserialize(rsp , LP_JSONAoe215Response.class);
        rp.doc = aux.base64File;
        rp.docblob = EncodingUtil.base64Decode(aux.base64File);
        return rp;
    }
}