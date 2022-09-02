/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : Obtains expiration share data from client. It takes from API 189.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_getMovementsData {
	/**
    *  @Description: Does the call and returns last movements data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static LP_Response GetMovementsDataCall(LP_Response rp){
        LP_Aoe189Call call = new LP_Aoe189Call(rp.rut, rp.dv);       	
        String rsp = call.call().getBody();    
        rp.lastMovements = new List<LP_JSONAoe189Response.Items>();
        LP_JSONAoe189Response aux = (LP_JSONAoe189Response)JSON.deserialize(rsp , LP_JSONAoe189Response.class);
        for(LP_JSONAoe189Response.Items a: aux.items){
            a.fechacompra = getFormattedDate(a.fechacompra);
            a.cuotas = String.valueof(a.numcuota) + '/' + String.valueof(a.totcuotas);
            rp.lastMovements.add(a);
        }
        return rp;
    }
    
    /**
    *  @Description: returns formatted date
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static String getFormattedDate(String fecha){
        String year = fecha.substring(0, 4);
        String month = fecha.substring(4, 6);
        String day = fecha.substring(6, 8);
        return (day + '/' + month + '/' + year);
    }
    
}