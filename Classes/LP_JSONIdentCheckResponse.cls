/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 10/06/2021
Description  : JSON response for Biometric Ident Check
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			10/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONIdentCheckResponse {
	public List<Items> items;
	public String transaction_id;

	/**
    *  @Description: JSON Item section
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
	public class Items {
        public String codigo;
        public Documento documento;
        public Transaccion transaccion;
        public Verificacion verificacion;
	}

    /**
    *  @Description: Documento Class
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public class Documento{
        public String tipo;
        public String fechaNacimiento;
        public String fechaExpiracion;
        public String nombres;
        public String pais;
        public String nacionalidad;
        public String apellidos;
        public String numero;
        public String adicionales;
        public String rut;
        public String estado;
    }

    /**
    *  @Description: Transaccion Class
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public class Transaccion {
        public String ipcliente;
        public String idcliente;
        public String fecha;
        public String origen;
        public String estado;
    }

    /**
    *  @Description: Verificacion Class
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    public class Verificacion {
        public String similitud;
        public String validez;
        public String coincidencia;
    }

    /**
    *  @Description: parse method
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
	public LP_JSONIdentCheckResponse parse(String json) {
		return (LP_JSONIdentCheckResponse) System.JSON.deserialize(json, LP_JSONIdentCheckResponse.class);
	}

}
