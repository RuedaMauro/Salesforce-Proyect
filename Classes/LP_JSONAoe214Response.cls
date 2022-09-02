/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : JSON response for AOE-214
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe214Response {
    public List<Items> items;
	public String transaction_id;


	/**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public Integer rut;
		public Integer deuda;
        public String dv;
        public Integer clave;
        public Integer cuota;
        public String fecfac;
        public String proxperfac;
        public String message;
        public String pan;
        public Integer status;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe214Response parse(String json) {
		return (LP_JSONAoe214Response) System.JSON.deserialize(json, LP_JSONAoe214Response.class);
	}
}