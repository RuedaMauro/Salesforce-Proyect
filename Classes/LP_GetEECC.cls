/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 03/08/2021
Description  : Get EECC from Client
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			03/08/2021		initial version
********************************************************************************/
public with sharing class LP_GetEECC {
    
    /**
*  @Description: Returns account states for the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/ 
	@AuraEnabled
    public static LP_Response getEECC(LP_Response rp){
        LP_Aoe214Call call = new LP_Aoe214Call(rp.rut);
        String rsp = call.call().getBody();
        LP_JSONAoe214Response aux = (LP_JSONAoe214Response)JSON.deserialize(rsp , LP_JSONAoe214Response.class);
        rp.docs = new List<LP_Response.getDocs>();
        for(LP_JSONAoe214Response.Items a: aux.items){
            LP_Response.getDocs dcs = new LP_Response.getDocs();
            dcs.rut = String.valueOf(a.rut);
            dcs.proxperfac = a.proxperfac;
            dcs.pan = a.pan;
            dcs.dv = a.dv;
            dcs.month = getMonth(a.proxperfac);
            dcs.year = getYear(a.proxperfac);
            rp.docs.add(dcs);
            rp.lastAccountState = rp.docs.get(0);
        }	  
        return rp;
    }
    
        /**
*  @Description: Gets the desired month.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/ 
    
    public static String getMonth(String fecemi){
        String month = fecemi.substring(4,6);
        switch on month {
            when '01' {
                month = 'Enero';
            }
            when '02' {
                month = 'Febrero';
            }
            when '03' {
                month = 'Marzo';
            }
            when '04' {
                month = 'Abril';
            }
            when '05' {
                month = 'Mayo';
            }
            when '06' {
                month = 'Junio';
            }
            when '07' {
                month = 'Julio';
            }
            when '08' {
                month = 'Agosto';
            }
            when '09' {
                month = 'Septiembre';
            }
            when '10' {
                month = 'Octubre';
            }
            when '11' {
                month = 'Noviembre';
            }
            when '12' {
                month = 'Diciembre';
            }
            when else{
                month = 'null';
            }
        }
        return month;
    }
    
        /**
*  @Description: Gets the desired year.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/ 
    
    public static String getYear(String fecemi){
       	String year = fecemi.substring(0,4);
        return year;
    }
}