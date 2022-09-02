/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : JSON response for AOE-207
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe207Response {
    
    public List<Items> items;
	public String transaction_id;


	/**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public String dispcompra;
		public String dispav;
        public Integer dispavxl;
        public String utilcompra;
        public String utilpav;
        public String utilavxl;
        public Integer cupoavance;
        public Integer cupoavancexl;
        public Integer utilsup;
        public String cupocompras;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe207Response parse(String json) {
		return (LP_JSONAoe207Response) System.JSON.deserialize(json, LP_JSONAoe207Response.class);
	}

}