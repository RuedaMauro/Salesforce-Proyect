/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/06/2021
Description  : JSON request for BeClever validation
History      : PCRM-19
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Alan Sanhueza Carrasco	     ASC
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       ASC        08/06/2021		  initial version
********************************************************************************/
public class LP_JSONBeCleverRequest {
	
	public LP_JSONHeaderRequest header;
	public Body body;
    
	
    /**
    *  @Description: JSON Item section
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Datosinput {
		public String Descripcion;
		public String Valor;
	}

	public class Body {
		public Integer idsistema;
		public Integer idflujo;
		public List<Datosinput> datosinput;
	}

	/**
    *  @Description: Parse method
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONBeCleverRequest parse(String json) {
		return (LP_JSONBeCleverRequest) System.JSON.deserialize(json, LP_JSONBeCleverRequest.class);
	}
}