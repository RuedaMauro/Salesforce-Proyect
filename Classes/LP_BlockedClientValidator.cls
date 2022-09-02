/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : Verifies if Client is blocked.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_BlockedClientValidator {

    /**
    *  @Description: Makes the call with Rut and dv come from a client to see if he or she is blocked.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021  
    */
    public static LP_Response blockClientValidatorCall(LP_Response rp){
            LP_Aoe1172Call call = new LP_Aoe1172Call(rp.cuenta, rp.centalta);
            String rsp = call.call().getBody();
            LP_JSONAoe1172Response aux = (LP_JSONAoe1172Response)JSON.deserialize(rsp , LP_JSONAoe1172Response.class);
            rp.blockCode = aux.items[0].bloqueo;
            return rp;
    }
    
}