/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 02/06/2021
Description  : JSON response for Azurian validation
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			02/06/2021		initial version
********************************************************************************/

public with sharing class LP_JSONAzurianResponse {

	public List<Items> items;
	public String transaction_id;
    public List<Errors> errors;
    public String dateError;

	/**
    *  @Description: JSON Item section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        02/06/2021
    */
	public class Items {
		public String timestamp;
        public String contents;
        public String token;
		public String scanReference;
		public String status;
        public String transactionReference;
        public String redirectUrl;
	}

	/**
    *  @Description: JSON Error section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        02/06/2021
    */
	public class Errors {
		public String message;
	}

    /**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        02/06/2021
    */
	public LP_JSONAzurianResponse parse(String json) {
		return (LP_JSONAzurianResponse) System.JSON.deserialize(json, LP_JSONAzurianResponse.class);
	}
}