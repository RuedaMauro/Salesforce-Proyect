/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : JSON response for AOE-646
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			25/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe646Response {
	public List<Items> items;
	public String transaction_id;
    
    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021
    */
	public class Items {
		public String fechaVencimiento;
		public String facturada;
        public String deudatotal;
	}
    
    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        25/06/2021
    */
	public static LP_JSONAoe646Response parse(String json) {
		return (LP_JSONAoe646Response) System.JSON.deserialize(json, LP_JSONAoe646Response.class);
	}
}