/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 24/06/2021
Description  : JSON response for AOE-220
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			24/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe220Response {
	
    public List<Items> items;
	public String transaction_id;
    
    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        24/06/2021
    */
	public class Items {
		public String pan;
		public String centalta;
        public String dias_mora;
        public String tipofac;
        public String tipofac3;
        public Integer cuotamax;
        public Integer cuotamin;
        public String tipo_cliente;
        public String tasa;
        public String tasa3;
        public Integer deudacompra;
        public String deudaavance;
        public String deudaavancexl;
        public Integer deudatotal;
        public String tipo_operacion;
	}
    
    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        24/06/2021
    */
	public static LP_JSONAoe220Response parse(String json) {
		return (LP_JSONAoe220Response) System.JSON.deserialize(json, LP_JSONAoe220Response.class);
	}
}