/*********************************************************************************
Project      : LA POLAR Salesforce - Private Site
Created By   : Deloitte
Created Date : 05/08/2021
Description  : JSON Request for Login Validation
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			05/08/2021		initial version
********************************************************************************/
public inherited sharing class LP_JSONLoginValidationRequest {

    public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    public class Body{

        public String username;
        public String password;
        public String initializationVector;

    }

	/**
    *  @Description: parse method
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
	public static LP_JSONLoginValidationRequest parse(String json) {
		return (LP_JSONLoginValidationRequest) System.JSON.deserialize(json, LP_JSONLoginValidationRequest.class);
	}
}