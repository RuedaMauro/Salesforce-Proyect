/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 28/07/2021
Description  : JSON response for AOE-221
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			28/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe221Response {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		@AuraEnabled public String imptotalL1;
		@AuraEnabled public String impcuotaL1;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe221Response parse(String json) {
		return (LP_JSONAoe221Response) System.JSON.deserialize(json, LP_JSONAoe221Response.class);
	}

}