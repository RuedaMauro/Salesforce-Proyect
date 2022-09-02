/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : Obtains data from client balance status, it takes from API-207
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			25/06/2021		initial version
********************************************************************************/
public class LP_GetBalanceData {
	
    /**
    *  @Description: Makes the call and returns balance data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static LP_Response getBalanceDataCall(LP_Response rp){
        LP_Aoe207Call call = new LP_Aoe207Call(rp.rut, rp.dv);
        String rsp = call.call().getBody();
        LP_JSONAoe207Response aux = (LP_JSONAoe207Response)JSON.deserialize(rsp , LP_JSONAoe207Response.class);
        rp.dispcompra = aux.items[0].dispcompra;
        rp.dispav = aux.items[0].dispav;
        rp.dispavxl = aux.items[0].dispavxl;
     	rp.cupoavancexl = aux.items[0].cupoavancexl;
        rp.utilcompra = aux.items[0].utilcompra;
        rp.utilpav = aux.items[0].utilpav;
        rp.utilavxl = aux.items[0].utilavxl;
        rp.cupocompras = aux.items[0].cupocompras;
        rp.utilsup = aux.items[0].utilsup;
        rp.cupoavance = aux.items[0].cupoavance;
        return rp;
    }
}