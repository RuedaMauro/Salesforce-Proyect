/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 06/08/2021
Description  : JSON request for AOE-151
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye     RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			06/08/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe151Request {
    public LP_JSONHeaderRequest header;
	public Body body;

    /**
    *  @Description: JSON Body section
    *  @Autor:       RSO, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/08/2021
    */
	public class Body {
		public Integer rut; // solo la parte numerica (sin DV)
	}

    /**
    *  @Description: parse method
    *  @Autor:       RSO, Deloitte, rosalinas@deloitte.com
    *  @Date:        06/08/2021
    */
	public static LP_JSONAoe151Request parse(String json) {
		return (LP_JSONAoe151Request) System.JSON.deserialize(json, LP_JSONAoe151Request.class);
	}
}