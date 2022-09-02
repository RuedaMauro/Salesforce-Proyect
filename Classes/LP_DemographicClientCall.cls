/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : Obtains Demographic API Call Data.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_DemographicClientCall {
    
    /**
*  @Description: Makes the call and obtain demographic data of the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    public static LP_Response demographicClientCall(LP_Response rp){
        LP_Aoe279Call call = new LP_Aoe279Call(rp.rut, rp.dv);       	
        String rsp = call.call().getBody();        	
        LP_JSONAoe279Response aux = (LP_JSONAoe279Response)JSON.deserialize(rsp , LP_JSONAoe279Response.class);
        rp.name = aux.items[0].name;
        rp.last_Name_1 = aux.items[0].last_Name_1;
        rp.last_Name_2 = aux.items[0].last_Name_2;
        rp.email = aux.items[0].email;
        rp.no_movil = aux.items[0].no_movil;
        return rp;
    }
    
    /**
*  @Description: Makes the call and obtain demographic data of the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    public static LP_Response demographicClientCallEmail(LP_Response rp){
        LP_Aoe279Call call = new LP_Aoe279Call(rp.rut, rp.dv);       	
        String rsp = call.call().getBody();        	
        LP_JSONAoe279Response aux = (LP_JSONAoe279Response)JSON.deserialize(rsp , LP_JSONAoe279Response.class);
        rp.email = aux.items[0].email;
        if(aux.items[0].email == null){
            rp.email = '';
        }
        return rp;
    }
}