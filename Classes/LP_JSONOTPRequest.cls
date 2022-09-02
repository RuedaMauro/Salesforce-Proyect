/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON request for OTP validation
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			17/05/2021		initial version
********************************************************************************/
public with sharing class LP_JSONOTPRequest{
    
	public LP_JSONHeaderRequest header;
	public Body body;

	/**
    *  @Description: JSON Body section
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
	public class Body {
		public String userId;
		public String operationId;
		public String cuotas;
		public String montoTotal;
		public String userEmail;
		public String userPhone;
	}
	
	/**
    *  @Description: parse method
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
	public static LP_JSONOTPRequest parse(String json) {
		return (LP_JSONOTPRequest) System.JSON.deserialize(json, LP_JSONOTPRequest.class);
	}
}