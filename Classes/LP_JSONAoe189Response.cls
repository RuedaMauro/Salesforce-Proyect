/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : JSON response for AOE-189
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			12/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe189Response {
	
    public List<Items> items;
	public String transaction_id;


	/**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		@AuraEnabled public Integer numcuota;
		@AuraEnabled public Integer totcompra;
        @AuraEnabled public Integer valcuota;
        @AuraEnabled public String descmov;
        @AuraEnabled public String fechacompra;
        @AuraEnabled public Integer totcuotas;
        @AuraEnabled public String cuotas;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe189Response parse(String json) {
		return (LP_JSONAoe189Response) System.JSON.deserialize(json, LP_JSONAoe189Response.class);
	}
}