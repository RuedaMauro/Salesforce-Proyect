/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : JSON response for AOE-212
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe212Response {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public class Items {
		@AuraEnabled public String monto;
		@AuraEnabled public String fecha;
        @AuraEnabled public String montov;
        @AuraEnabled public String fechav;
        @AuraEnabled public String estadov;
        @AuraEnabled public String clave_inicio;
        @AuraEnabled public String clave_fin;
        @AuraEnabled public String pantalla_pag;
        @AuraEnabled public String ind_mas_datos;
        @AuraEnabled public String otros_datos;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe212Response parse(String json) {
		return (LP_JSONAoe212Response) System.JSON.deserialize(json, LP_JSONAoe212Response.class);
	}
}