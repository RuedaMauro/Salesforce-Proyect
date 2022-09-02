/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : Obtains expiration share data from client. It takes from API 212.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			25/06/2021		initial version
********************************************************************************/
public with sharing class LP_GetExpirationShareData {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String STATUS_FUTURE;
    private static final String RQ_HEADER_COUNTRY;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        STATUS_FUTURE = 'FUTURO';
    }
    
	/**
    *  @Description: Does the call and returns expiration share data from client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static List<LP_JSONAoe212Response.Items> GetExpirationShareDataCall(LP_Response rp){
        Integer mark = 0;
        List<LP_JSONAoe212Response.Items> response = new List<LP_JSONAoe212Response.Items>();
        LP_Aoe212Call call = new LP_Aoe212Call(rp.cuenta, rp.centalta);
        String rsp = call.call().getBody();
        LP_JSONAoe212Response aux = (LP_JSONAoe212Response)JSON.deserialize(rsp , LP_JSONAoe212Response.class);
        for(Integer i = 0; i < aux.items.size(); i++){
            if(aux.items[i].estadov == STATUS_FUTURE && mark < 5){
                response.add(aux.Items[i]);
                mark++;
            }
        }
        if(response.size() > 0){
            for(Integer i = 0; i < response.size(); i++){
            	response[i].fechav = getFormattedDate(response[i].fechav);   
            }               
        }
        return response;
    }
    
    /**
    *  @Description: change structure of date to the form mm/yyyy
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021  
    */
    @AuraEnabled
    public static String getFormattedDate(String fecha){
    	List<String> str = fecha.Split('-',3);
    	String day = str[0];
    	String month = str[1];
    	return(day + '/' + month);
    }
}