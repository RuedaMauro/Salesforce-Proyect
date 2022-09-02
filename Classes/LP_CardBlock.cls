/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : Blocks and unblocks client's card.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_CardBlock {
    
	/**
    *  @Description: Blocks client's card
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        13/07/2021  
    */
    public static LP_Response blockCard(LP_Response rp){
            LP_Aoe225Call call = new LP_Aoe225Call(rp.tarjetaEmitidaPan, 77);       	
            String rsp = call.call().getBody();        	
            LP_JSONAoe225Response aux = (LP_JSONAoe225Response)JSON.deserialize(rsp , LP_JSONAoe225Response.class);
        	rp.loginOK = true;
        	rp.message = aux.Items[0].message;
            return rp;
    }
    
    /**
    *  @Description: Unblock client's card
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        13/07/2021  
    */
    public static LP_Response unblockCard(LP_Response rp){
            LP_Aoe225Call call = new LP_Aoe225Call(rp.tarjetaEmitidaPan, 0);       	
            String rsp = call.call().getBody();        	
            LP_JSONAoe225Response aux = (LP_JSONAoe225Response)JSON.deserialize(rsp , LP_JSONAoe225Response.class);
        	rp.message = aux.Items[0].message;
            return rp;
    }
}