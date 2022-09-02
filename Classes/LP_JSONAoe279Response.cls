/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : JSON response for AOE-279
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe279Response {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public String security_Code;
		public String last_Name_1;
        public String last_Name_2;
        public String name;
        public String date_birthday;
        public String email;
        public String desc_Postal_1;
        public String desc_Postal_1_num;
        public String desc_Postal_2;
        public String no_movil;
        public String election;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe279Response parse(String json) {
		return (LP_JSONAoe279Response) System.JSON.deserialize(json, LP_JSONAoe279Response.class);
	}

}