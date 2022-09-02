/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON response for Asset Laundering validation
History      : PCRM-12
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			17/05/2021		initial version
********************************************************************************/
public class LP_JSONAssetLaundResponse {

	public List<Items> items;
	public String transaction_id;

	/**
    *  @Description: JSON Item section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        17/05/2021
    */
	public class Items {
		public Integer estatus;
		public Integer autorizado;
        public Integer id_request;
        public Integer id_emp;
		public String source;
        public Double codStatus;
	}

	/**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        17/05/2021
    */
	public LP_JSONAssetLaundResponse parse(String json) {
		return (LP_JSONAssetLaundResponse) System.JSON.deserialize(json, LP_JSONAssetLaundResponse.class);
	}
}