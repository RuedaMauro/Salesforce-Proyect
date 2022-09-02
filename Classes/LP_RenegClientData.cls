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
public with sharing class LP_RenegClientData {
	
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String REF_SITUATION;
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        REF_SITUATION = 'REF';
    }
    
    /**
    *  @Description: Makes the call and returns renegotiation data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        24/06/2021  
    */
    @AuraEnabled
    public static LP_Response renegClientDataCall(LP_Response rp){
        LP_Aoe220Call call = new LP_Aoe220Call(rp.rut, rp.dv);
        String rsp = call.call().getBody();
        LP_JSONAoe220Response aux = (LP_JSONAoe220Response)JSON.deserialize(rsp , LP_JSONAoe220Response.class);
        rp.cuotamax = aux.items[0].cuotamax;
        rp.cuotamin = aux.items[0].cuotamin;
        rp.dias_mora = aux.items[0].dias_mora;
        rp.tipofac = aux.items[0].tipofac;
        rp.tipofac3 = aux.items[0].tipofac3;
        rp.tasa = aux.items[0].tasa;
        rp.tasa3 = aux.items[0].tasa3;
        rp.deudacompra = String.valueOf(aux.items[0].deudacompra);
        rp.deudaavance = aux.items[0].deudaavance;
        rp.deudaavancexl = aux.items[0].deudaavancexl;
        rp.deudatotal_r = Integer.valueOf(aux.items[0].deudatotal);
        if(aux.items[0].tipo_operacion == REF_SITUATION){
            rp.renegSituation = true;
        } 
        else{
            rp.renegSituation = false;
        }
        return rp;
    }
}