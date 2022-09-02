/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : JSON request for AOE-225
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe225Request {
	public LP_JSONHeaderRequest header;
	public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public class Body {
		public String pan;
		public Integer codBloq;
        public String descripcion;
        public String origen;
        public Integer nroTienda;
        public String ip;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe225Request parse(String json) {
		return (LP_JSONAoe225Request) System.JSON.deserialize(json, LP_JSONAoe225Request.class);
	}
}