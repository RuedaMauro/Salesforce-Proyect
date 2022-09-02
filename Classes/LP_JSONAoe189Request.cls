/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 09/07/2021
Description  : JSON request for AOE-189
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			09/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe189Request {
	public LP_JSONHeaderRequest header;
	public Body body;
    
    /**
    *  @Description: JSON Body section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class Body {
		public Integer rut;
		public String dv;
		public String channel;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe189Request parse(String json) {
		return (LP_JSONAoe189Request) System.JSON.deserialize(json, LP_JSONAoe189Request.class);
	}
}