/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : Obtains debt and payment data from client. It takes from API IA-646.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			25/06/2021		initial version
********************************************************************************/
public with sharing class LP_GetDebtPayment {
    /**
    *  @Description: Does the call and returns Debt and payment data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static LP_Response GetDebtPaymentDataCall(LP_Response rp){
    
		LP_Aoe646Call call = new LP_Aoe646Call(rp.rut, rp.dv);
   	    String rsp = call.call().getBody();
    	LP_JSONAoe646Response aux = (LP_JSONAoe646Response)JSON.deserialize(rsp , LP_JSONAoe646Response.class);
    	rp.fechaVencimiento = aux.items[0].fechaVencimiento;
        rp.fechaFacturacion = getFormattedDate(rp.fechaVencimiento);
        rp.facturada = aux.items[0].facturada;
        rp.deudatotal = aux.items[0].deudatotal;
        if(Integer.valueOf(rp.facturada) > 0){ 
            rp.deudaPendiente = true;
        }
        else{ 
            rp.deudaPendiente = false;
        }
        return rp;
	}
    
    /**
    *  @Description: Get spanish month name from Date.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static String getFormattedDate(String fecha){
    List<String> str = fecha.Split('-',3);
    String month = str[1];
    String year = str[2];
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
        return(month + '/' + year);
    }
    
    
}