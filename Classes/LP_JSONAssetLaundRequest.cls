/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON request for Asset Laundering validation
History      : PCRM-12 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			17/05/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAssetLaundRequest{
    
	public LP_JSONHeaderRequest header;
	public Body body;

	/**
    *  @Description: JSON Body section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        17/05/2021
    */
	public class Body {
		public Integer NUMRUT;
		public String DIGRUT;
		public String nombres;
		public String apellidos;
		public String nacionalidad;
        public String tipo;
        public String estatus;
        public String autorizado;
        public Integer id_emp;
        public String source;
        public Integer id_request;
	}

	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        17/05/2021
    */
	public static LP_JSONAssetLaundRequest parse(String json) {
		return (LP_JSONAssetLaundRequest) System.JSON.deserialize(json, LP_JSONAssetLaundRequest.class);
	}
}