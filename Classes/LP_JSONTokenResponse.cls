/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 08/04/2021
Description  : class response for token.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Leonardo Muñoz			    LM
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      LM			08/04/2021		    Created Class
********************************************************************************/
public with sharing class LP_JSONTokenResponse {

    public String refresh_token_expires_in;
	public String api_product_list;
	public List<String> api_product_list_json;
	public String organization_name;
	public String developer_email;
	public String token_type;
	public String issued_at;
	public String client_id;
	public String access_token;
	public String application_name;
	public String scope;
	public String expires_in;
	public String refresh_count;
	public String status;

	public static LP_JSONTokenResponse parse(String json) {
		return (LP_JSONTokenResponse) System.JSON.deserialize(json, LP_JSONTokenResponse.class);
	}
}