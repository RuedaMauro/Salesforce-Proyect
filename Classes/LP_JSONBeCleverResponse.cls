/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/06/2021
Description  : JSON response for BeClever validation
History      : PCRM-19
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Alan Sanhueza Carrasco	     ASC
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       ASC        08/06/2021		  initial version
********************************************************************************/
public class LP_JSONBeCleverResponse {

	public List<Items> items;
	public String transaction_id;
	
    /**
    *  @Description: JSON Item section
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public List<VariablesEntrada> VariablesEntrada;
		public List<VariablesEntrada> VariablesSalida;
		public List<VariablesEntrada> VariablesDecision;
		public List<VariablesEntrada> VariablesAuditoria;
		public String TrackHojas;
		public String TrackDecisiones;
		public String TrackAdvertencias;
		public String Errores;
		public String VersionFlujo;
	}

	public class VariablesEntrada {
		public String Descripcion;
		public String Valor;
	}
	
    /**
    *  @Description: Parse method
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
	public LP_JSONBeCleverResponse parse(String json) {
		return (LP_JSONBeCleverResponse) System.JSON.deserialize(json, LP_JSONBeCleverResponse.class);
	}
}