/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON request for Azurian Service (init, consult and validate)
History      : PCRM-15 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			02/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAzurianRequest {

    public LP_JSONHeaderRequest header;
    public Body body;    
    
    /**
    *  @Description: JSON Body section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        02/06/2021
    */
    public class Body {
        //init and common
        public Integer NumRut;
        public String DigRut;
        public String Action;
        public String j_customerInternalReference;
        public String j_UserReference;
        public String j_SuccessUrl;
        public String j_ErrorUrl;
        public String j_CallbackUrl;
        public String j_reportingCriteria;
        public Integer j_workflowId;
        public String j_Locale;
        public String j_Azurian_administrationClientKey;
        public String j_Azurian_civilRegistryAction;
        public String j_Azurian_civilRegistryValid;
        public String j_Azurian_civilRegistryDate;
        public String j_Azurian_scanreference;
        //Consult
        public String j_Get_scanreference;
        //Validate
        public String j_Azurian_civilRegistryRawResponse;
    }
	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        02/06/2021
    */
	public static LP_JSONAzurianRequest parse(String json) {
		return (LP_JSONAzurianRequest) System.JSON.deserialize(json, LP_JSONAzurianRequest.class);
	}
}