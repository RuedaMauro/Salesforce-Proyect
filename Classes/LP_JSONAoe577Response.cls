/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : JSON response for AOE-577
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe577Response {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public Integer clienteRut;
		public String clienteDv;
        public String clienteNombreCompleto;
        public String clienteIdentificador;
        public String clienteCuenta;
        public String clienteCentroAlta;
        public String tarjetaId;
        public String tarjetaEmitidaPan;
        public String tarjetaEmitidaPosesion;
        public String tarjetaEmitidaEstado;
        public String tarjetaEmitidaFechaEmision;
        public String tarjetaEmitidaFechaVenc;
        public String tarjetaCod;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe577Response parse(String json) {
		return (LP_JSONAoe577Response) System.JSON.deserialize(json, LP_JSONAoe577Response.class);
	}
}