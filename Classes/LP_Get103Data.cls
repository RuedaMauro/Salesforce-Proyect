/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 24/06/2021
Description  : Obtains data
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			24/06/2021		initial version
********************************************************************************/
public with sharing class LP_Get103Data {
	
    /**
    *  @Description: Makes the call and returns renegotiation data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        24/06/2021  
    */
    @AuraEnabled
    public static String get103Data(String code){
        LP_Aoe103Call call = new LP_Aoe103Call(code, 'LAPOLAR');
        String rsp = call.call().getBody();
        LP_JSONAoe103Response aux = (LP_JSONAoe103Response)JSON.deserialize(rsp , LP_JSONAoe103Response.class);
        return aux.items[0].result[0].file_preview;
    }
}