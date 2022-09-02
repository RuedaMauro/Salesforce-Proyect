/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : Get Client credits card.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_getCreditCardList {
    /**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response getCreditCardList(Integer rut, String dv){
        LP_Response rp = new LP_Response();
        LP_Aoe224Call call = new LP_Aoe224Call(rut, dv);
        rp.rut = rut;
        rp.dv = dv;
        String rsp = call.call().getBody();
        LP_JSONAoe224Response aux = (LP_JSONAoe224Response)JSON.deserialize(rsp , LP_JSONAoe224Response.class);
        for(Integer i = 0; i < aux.items.size(); i++){
            LP_Response.Aditionals adt = new LP_Response.Aditionals();
            if(aux.items[i].pan.substring(0,4) == '4786' || aux.items[i].pan.substring(0,4) == '5610'){
                adt.name = aux.items[i].nombre;
                adt.pan = aux.items[i].pan;
                if(aux.items[i].tarcta == '1'){
                    adt.isPrimary = true;
                }
                else{
                    adt.isPrimary = false;
                }
                rp.aditionals.add(adt);
            }
        }
        return rp;
    }
}