/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : JSON response for Customer Contract create Service
History      : PCRM-20
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			08/07/2021		initial version
********************************************************************************/

public with sharing class LP_JSONCustomerContractCreateResponse {
	public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        08/07/2021
    */
	public class Items {
		public Integer status;
		public String message;
		public String session_id;
		public Result result;
	}

    /**
    *  @Description: JSON Result section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        08/07/2021
    */
	public class Result {
		public String code;
	}

	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        08/07/2021
    */
	public static LP_JSONCustomerContractCreateResponse parse(String json) {
		return (LP_JSONCustomerContractCreateResponse) System.JSON.deserialize(json, LP_JSONCustomerContractCreateResponse.class);
	}
}