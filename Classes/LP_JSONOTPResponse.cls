/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON response for OTP validation
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			05/01/2020		initial version
********************************************************************************/
public class LP_JSONOTPResponse {

	public List<Items> items;
	public String transaction_id;

	/**
    *  @Description: JSON Item section
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/01/2020
    */
	public class Items {
		public Integer statusCode;
		public String statusDescription;
		public String data;
	}

	/**
    *  @Description: parse method
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/01/2020
    */
	public static LP_JSONOTPResponse parse(String json) {
		return (LP_JSONOTPResponse) System.JSON.deserialize(json, LP_JSONOTPResponse.class);
	}
}