/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : JSON response to create documents
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdón Tejos Oliva           ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			08/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONCustomerGetDocumentsResponse {
    
	public List<Items> items;
	public String transaction_id;
	
	/**
	*  @Description: JSON Signers section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Signers {
		public String name;
		public String role;
		public String institution;
		public String rut;
		public String email;
		public Integer type;
		public Integer state;
		public Integer order;
		//public String date_Z;// in json: date
		public String audit;
		public String notify;
		public String opciones_firma;
		public String habilitado;
		public Integer who_signs;
	}
	
	/**
	*  @Description: JSON Items section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Items {
		public Integer status;
		public String message;
		public String session_id;
		public List<Result> result;
	}
	
	/**
	*  @Description: JSON Creator section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Creator {
		public String name;
		public String role;
		public String institution;
		public String rut;
	}

	/**
	*  @Description: JSON CanSignInfo section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class CanSignInfo {
		public String role;
		public String institution;
		public Integer type;
		public String rut;
	}

	/**
	*  @Description: JSON Result section
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Result {
		public String name;
		public String code;
		public String type_code;
		public String country_code;
		public String state;
		//public String date_Z;// in json: date
		public String end_date;
		public Integer can_sign;
		public List<CanSignInfo> can_sign_info;
		public Integer security;
		public String file_preview;
		public Creator creator;
		public List<Signers> signers;
	}

	/**
	*  @Description: parse method
	*  @Autor:       ATO, Deloitte, atejoso@deloitte.com
	*  @Date:        08/07/2021
	*/
	public static LP_JSONCustomerGetDocumentsResponse parse(String json) {
		return (LP_JSONCustomerGetDocumentsResponse) System.JSON.deserialize(json, LP_JSONCustomerGetDocumentsResponse.class);
	}
}