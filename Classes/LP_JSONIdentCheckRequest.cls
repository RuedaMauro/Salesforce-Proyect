/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 10/06/2021
Description  : JSON request for Biometric Ident Check Service 
History      : PCRM-15 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			10/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONIdentCheckRequest {
    public LP_JSONHeaderRequest header;
    public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public class Body {
        public Integer rut;
        public String dv;
        public String scanReference;
    }
	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
	public static LP_JSONIdentCheckRequest parse(String json) {
		return (LP_JSONIdentCheckRequest) System.JSON.deserialize(json, LP_JSONIdentCheckRequest.class);
	}
}
