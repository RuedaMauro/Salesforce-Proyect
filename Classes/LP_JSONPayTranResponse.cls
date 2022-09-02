/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 29/07/2021
Description  : JSON response for Paying api.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			29/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONPayTranResponse {
	public String url;
    public String token;
    
    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONPayTranResponse parse(String json) {
		return (LP_JSONPayTranResponse) System.JSON.deserialize(json, LP_JSONPayTranResponse.class);
	}
}