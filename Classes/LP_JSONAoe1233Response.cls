/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : JSON response for AOE-1233
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe1233Response {
    
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		@AuraEnabled public String statusRetorno;
		@AuraEnabled public String descRetorno;
        @AuraEnabled public Integer cantRegistros;
        @AuraEnabled public String clienteNombreCompleto;
        @AuraEnabled public String tarjetaEmitidaEstado;
        @AuraEnabled public String tarjetaEmitidaFechaEmision;
        @AuraEnabled public String tarjetaEmitidaFechaVenc;
        @AuraEnabled public String tarjetaVencM;
        @AuraEnabled public String tarjetaVencA;
        @AuraEnabled public String tarjetaCod;
        @AuraEnabled public String tarjetaId;
        @AuraEnabled public String tarjetaEmitidaPosesion;
        @AuraEnabled public String clienteCentroAlta;
        @AuraEnabled public String clienteIdentificador;
        @AuraEnabled public Integer clienteRut;
        @AuraEnabled public String clienteDv;
        @AuraEnabled public String clienteCuenta;
        @AuraEnabled public registros registros;
	}

    /**
    *  @Description: Register Array class from response.
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
    public class registros{
        public String codTar;
    }


    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe1233Response parse(String json) {
		return (LP_JSONAoe1233Response) System.JSON.deserialize(json, LP_JSONAoe1233Response.class);
	}
}