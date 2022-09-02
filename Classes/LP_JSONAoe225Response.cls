/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : JSON response for AOE-25
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe225Response {
	public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public class Items {
        @AuraEnabled public String code;
        @AuraEnabled public String message;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe225Response parse(String json) {
		return (LP_JSONAoe225Response) System.JSON.deserialize(json, LP_JSONAoe225Response.class);
	}
}