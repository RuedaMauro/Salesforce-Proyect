/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 25/06/2021
Description  : JSON request for Customer Sign Autentia Service 
History      : PCRM-21 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			25/06/2021		initial version
********************************************************************************/
public without sharing class LP_JSONCustomerSignRequest {
    public LP_JSONHeaderRequest header;
    public Body body;
    
    /**
    *  @Description: JSON Body section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        25/06/2021
    */
    public class Body {
 
        public Integer user_rut;
        public String digito;
        public String nombres;
        public String apellidos;
        public String user_role;
        public String tipo;
        public String user_institution;
        public Integer local;
        public Integer numven;
        public Integer digven;
        public String numero;
        public String audit;
        public String code;
        public String session_id;
    }
    
	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        25/06/2021
    */
	public static LP_JSONCustomerSignRequest parse(String json) {
		return (LP_JSONCustomerSignRequest) System.JSON.deserialize(json, LP_JSONCustomerSignRequest.class);
	}
}