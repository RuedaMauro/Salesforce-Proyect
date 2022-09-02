/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : JSON response for AOE-966
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe966Response {
    public List<Items> items;
	public String transaction_id;


	/**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public String codent;
		public String pan;
        public String tiposolpin;
        public String pinblock;
        public String pinblockold;
        public String codrespu;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe966Response parse(String json) {
		return (LP_JSONAoe966Response) System.JSON.deserialize(json, LP_JSONAoe966Response.class);
	}
}