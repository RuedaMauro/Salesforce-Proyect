/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : JSON request for AOE-966
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe966Request {
    public LP_JSONHeaderRequest header;
	public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class Body {
		public String pan;
		public String pin;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe966Request parse(String json) {
		return (LP_JSONAoe966Request) System.JSON.deserialize(json, LP_JSONAoe966Request.class);
	}
}