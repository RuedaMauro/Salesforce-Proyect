/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : JSON request to create customer
History      : PCRM-23
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Fran Oseguera           	FA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      FAA			05/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONCustomerCreateRequest {

    public LP_JSONHeaderRequest header;
    public Body body;    
    
    /**
    *  @Description: JSON Body section
    *  @Autor:       FO, Deloitte
    *  @Date:        05/06/2021
    */
    public class Body {
        public integer NUMRUT;
        public String DIGRUT;
        public String TIPCLIEN;
        public String LIMCRECTA1IMP;
        public String NOMBENREDTAR;
        public String POBLACION;
        public String GRUPOLIQ;
        public String NOMBRE;
        public String PRODUCTO;
        public String SUBPRODU;
        public String INDESTCIV;
        public String DESCLAVE4;
        public String TIPVIA;
        public String CODPROF;
        public String NUMVIA;
        public String CONPROD;
        public String FECINIL1;
        public String CODPROV;
        public String FECCADTAR;
        public String FECINIL3;
        public String FECINIL2;
        public String CALPARTTAR;
        public String NUMDOC;
        public String APELLI2;
        public String APELLI1;
        public String SEXPER;
        public String NOMVIA;
        public String FECNAC;
        public String GRUPOCUO;
        public String CODREGIMEN;
        public String LIMCRELINL3;
        public String RESTODIR;
        public String LIMCRELINL1;
        public String CODENT;
        public String CODREGION;
        public String LIMCRELINL2;
        public String PANASOCTAR;
        public String NOMBREEMP;
        public String CENTALTA;
        public integer p_desgra;
        public integer p_cesant;
        public integer p_diapag;
        public String CEDULASERIE;
        public String p_compar;
        public integer p_local;
        public integer p_rutcap;
        public String p_digcap;
        public String p_item_contrato;
        public String p_num_contrato;
        public String p_cod_aut;
        public String p_num_mandato;
        public String p_num_resumen;
        public String p_cod_autman;
        public String p_cod_autres;
        public String p_num_consenti;
        public String p_cod_consenti;
        public String p_num_anexo1;
        public String p_num_anexo2;
        public String p_num_anexo3;
        public String p_num_solren;
        public String p_cod_autsre;
        public String p_num_solcyt;
        public String p_cod_autcyt;
        public String p_num_solcrt;
        public String p_cod_autcrt;
        public integer p_rutsecu;
        public String p_item_canal;
        public String p_num_fip;
        public String p_cod_fip;
        public String p_tipo_tarjeta;
        public String in_posesion;
        public String MAIL;
        public String TIPOVIVIENDA;
        public String CELULAR;
        public String CODCEL;
        public String nacionalidad;
        public String personal_direccion_referencia;
        public String p_fecnac;
        public String dirpar;
        public integer in_titular_rut;
        public String in_titular_dv;
        public String in_tarjeta_cod;
        public String in_fecha_emision;
        public String condesttar;
        public String tipo_eleccion;
        public String subtipo_eleccion;
        public String valor_eleccion;
        public String canal_origen;

    }

    /**
    *  @Description: parse method
    *  @Autor:       FO, Deloitte
    *  @Date:        05/06/2021
    */
	public static LP_JSONCustomerCreateRequest parse(String json) {
		return (LP_JSONCustomerCreateRequest) System.JSON.deserialize(json, LP_JSONCustomerCreateRequest.class);
	}
}