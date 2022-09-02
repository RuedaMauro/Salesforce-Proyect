/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 06/08/2021
Description  : JSON response for AOE-151
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye     RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			06/08/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe151Response {
	public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       RSO, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/08/2021
    */
	public class Items {
		public String nomcli;
		public String nomloc;
		public String descri;
		public String fecha;
		public String codigo;
		public String numero;   // codigo de documento
		public String nomven;
		public String nomdoc;
		public Integer status;
	}

    /**
    *  @Description: parse method
    *  @Autor:       RSO, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/08/2021
    */
	public static LP_JSONAoe151Response parse(String json) {
		return (LP_JSONAoe151Response) System.JSON.deserialize(json, LP_JSONAoe151Response.class);
	}

}