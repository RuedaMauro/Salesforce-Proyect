/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : JSON request for Customer Contract create Service 
History      : PCRM-20 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			08/07/2021		initial version
********************************************************************************/

public with sharing class LP_JSONCustomerContractCreateRequest {
	public LP_JSONHeaderRequest header;
	public Body body;

	/**
	*  @Description: JSON Body section
	*  @Autor:       EAA, Deloitte, eandradea@deloitte.com
	*  @Date:        08/07/2021
	*/
	public class Body {
		public Integer tipoContrato;
		public Integer rut;
		public String dv;
		public Integer categoria;
		public Integer cupo;
		public String type_code;
		public String institution;
		public String name;
		public List<String> signers_roles;
		public List<String> signers_institutions;
		public List<String> signers_emails;
		public List<String> signers_ruts;
		public List<Integer> signers_type;
		public List<Integer> signers_order;
		public List<Integer> signers_notify;
		public List<String> tags;
		public List<String> field_tags;
		public List<String> field_tags_values;
		public String comment;
		public String file;
		public String file_mime;
	}

	/**
	*  @Description: parse method
	*  @Autor:       EAA, Deloitte, eandradea@deloitte.com
	*  @Date:        08/07/2021
	*/	
	public static LP_JSONCustomerContractCreateRequest parse(String json) {
		return (LP_JSONCustomerContractCreateRequest) System.JSON.deserialize(json, LP_JSONCustomerContractCreateRequest.class);
	}
}