/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 05/01/2021
Description  : Header transversal for all queries
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			05/01/2021		initial version
********************************************************************************/
public with sharing class LP_JSONHeaderRequest {
    public String country;
    public String commerce;
    public String channel;
    //public String date_Z;// in json: date
    public String hour;
    public String operation;
    public String storeId;
    public String terminalId;

    /**
    *  @Description: parse method
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/01/2021
    */
	public static LP_JSONHeaderRequest parse(String json) {
		return (LP_JSONHeaderRequest) System.JSON.deserialize(json, LP_JSONHeaderRequest.class);
	}
}