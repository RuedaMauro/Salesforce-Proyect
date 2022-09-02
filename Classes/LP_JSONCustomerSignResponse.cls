/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 25/06/2021
Description  : JSON response for Customer Sign Autentia Service 
History      : PCRM-21 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			25/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONCustomerSignResponse {
	
    public List<Items> items;
    public List<Errors> errors;

	/**
    *  @Description: JSON Item section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        25/06/2021
    */
	public class Items {
		public String status;
        public String message;
        public String session_id;
		public String scanReference;
		public String result;
        public String descripcion;
        public String estado;
	}

	/**
    *  @Description: JSON Error section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        25/06/2021
    */
	public class Errors {
		public String message;
	}

    /**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        25/06/2021
    */
	public LP_JSONCustomerSignResponse parse(String json) {
		return (LP_JSONCustomerSignResponse) System.JSON.deserialize(json, LP_JSONCustomerSignResponse.class);
	}
}