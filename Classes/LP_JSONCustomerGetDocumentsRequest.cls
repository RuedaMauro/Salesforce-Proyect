
/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : JSON request to create documents
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdón Tejos Oliva           ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			08/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONCustomerGetDocumentsRequest {
    
	public LP_JSONHeaderRequest header;
	public Body body;
	
	/**
	*  @Description: JSON Body section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Body {
		public String code;
		public String institution;
		public String extra;
	}

	/**
	*  @Description: parse method
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public static LP_JSONCustomerGetDocumentsRequest parse(String json) {
		return (LP_JSONCustomerGetDocumentsRequest) System.JSON.deserialize(json, LP_JSONCustomerGetDocumentsRequest.class);
	}
}
