/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : JSON request for AOE-215
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe103Request {
	public LP_JSONHeaderRequest header;
	public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class Body {
		public String code;
		public String institution;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe103Request parse(String json) {
		return (LP_JSONAoe103Request) System.JSON.deserialize(json, LP_JSONAoe103Request.class);
	}
}