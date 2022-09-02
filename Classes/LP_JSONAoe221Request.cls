/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 28/07/2021
Description  : JSON request for AOE-221
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			28/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe221Request {
    public LP_JSONHeaderRequest header;
	public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Body {
		public String rut;
		public Integer cuotas;
		public String tasa;
        public String tipo_operacion;
		public String dias_mora;
		public String deuda_compra;
        public String deuda_avance;
		public String deuda_avancexl;
		public String deuda_renegociar;
        public String dia_pago;
		public String desfase;
		public String tipofact1;
        public String tipofact3;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe221Request parse(String json) {
		return (LP_JSONAoe221Request) System.JSON.deserialize(json, LP_JSONAoe221Request.class);
	}
}