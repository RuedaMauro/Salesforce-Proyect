/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 27/07/2021
Description  : Obtains history pay API Call Data.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			27/07/2021		initial version
********************************************************************************/
public with sharing class LP_GetPaymentHistory {
    
    /**
*  @Description: Makes the call and obtain pay history data form the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        27/07/2021  
*/
    public static LP_Response getPaymentHistory(LP_Response rp){
        LP_Aoe231Call call = new LP_Aoe231Call(rp.rut);       	
        String rsp = call.call().getBody();
        String historyPayment;
        LP_JSONAoe231Response aux = (LP_JSONAoe231Response)JSON.deserialize(rsp , LP_JSONAoe231Response.class);
        for(LP_JSONAoe231Response.Items a: aux.items){
            LP_Response.HistoryPayment hst = new LP_Response.HistoryPayment();
            hst.fecom = getFormattedDate(a.fecom);
            hst.month = getMonthDate(a.fecom);
            hst.monto = a.monto;
            hst.nombre = a.nombre;
            rp.paymentHistory.add(hst);
        }	        
        return rp;
    }
    
    public static String getFormattedDate(String fecha){
        String day = fecha.substring(6, 8);
        String dayd = fecha.substring(6, 8);
        String days = fecha.substring(6, 8);
        String month = fecha.substring(4,6);
        String year = fecha.substring(0,4);
        return(day + '/' + month + '/' + year);
    }
    
    /**
    *  @Description: Get spanish month name from Date.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static String getMonthDate(String fecha){
    String month = fecha.substring(4,6);
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
        return(month);
    }
}