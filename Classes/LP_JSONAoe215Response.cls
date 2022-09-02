/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : JSON response for AOE-215
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe215Response {
    public String base64File;
	public String transaction_id;

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe215Response parse(String json) {
		return (LP_JSONAoe215Response) System.JSON.deserialize(json, LP_JSONAoe215Response.class);
	}
}