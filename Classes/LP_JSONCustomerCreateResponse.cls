/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON request to create customer
History      : PCRM-23
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Fran Oseguera           	FA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      FAA			05/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONCustomerCreateResponse {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       FA, Deloitte
    *  @Date:        08/07/2021
    */
	public class Items {
		public Integer status;
		public String message;
		public String session_id;
		public Result result;
        public string DescExcepcion;
        public string codExcepcion;
	}

    /**
    *  @Description: JSON Result section
    *  @Autor:       FA, Deloitte
    *  @Date:        08/07/2021
    */
	public class Result {
		public String code;
	}

    /**
    *  @Description: parse method
    *  @Autor:       FA, Deloitte
    *  @Date:        08/07/2021
    */
	public static LP_JSONCustomerCreateResponse parse(String json) {
		return (LP_JSONCustomerCreateResponse) System.JSON.deserialize(json, LP_JSONCustomerCreateResponse.class);
	}
}