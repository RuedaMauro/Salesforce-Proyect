/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : JSON response for AOE-279
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe1422Response {
    public List<Items> items;
	public String transaction_id;

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public Integer dni_ingresa;
		public String fecha_creacion;
        public String personal_dni_cliente_serie;
        public String personal_fecha_nacimiento_cliente;
        public String personal_sexo_cliente;
        public String personal_estado_civil_cliente;
        public String personal_nombres_cliente;
        public String personal_apellido_paterno_cliente;
        public String personal_apellido_materno_cliente;
        public String personal_telefono_celular;
        public String personal_tipo_vivienda_desc;
		public String personal_direccion_tipo_via;
		public String personal_direccion_calle;
        public String personal_direccion_numero;
        public String personal_comuna;
        public String personal_ciudad;
        public String local_ingresa;
        public String laboral_nombre_empresa;
        public String laboral_ingreso;
        public String laboral_direccion_tipo_via;
        public String laboral_direccion_calle;
        public String laboral_ciudad;
        public String laboral_comuna;
        public String laboral_actividad;
        public String personal_comuna_desc;
        public String personal_ciudad_desc;
        public String laboral_ciudad_desc;
        public String laboral_comuna_desc;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONAoe1422Response parse(String json) {
		return (LP_JSONAoe1422Response) System.JSON.deserialize(json, LP_JSONAoe1422Response.class);
	}

}