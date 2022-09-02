/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 10/08/2021
Description  : Obtains Demographic API Call Data.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			10/08/2021		initial version
********************************************************************************/
public with sharing class LP_DemographicCall {
    
    /**
*  @Description: Makes the call and obtain demographic data of the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    public static LP_Response demographicClientCall(LP_Response rp){
        LP_Aoe1422Call call = new LP_Aoe1422Call(rp.rut, rp.dv);       	
        String rsp = call.call().getBody();        	
        LP_JSONAoe1422Response aux = (LP_JSONAoe1422Response)JSON.deserialize(rsp , LP_JSONAoe1422Response.class);
        rp.name = aux.items[0].personal_nombres_cliente;
        rp.last_Name_1 = aux.items[0].personal_apellido_paterno_cliente;
        rp.last_Name_2 = aux.items[0].personal_apellido_materno_cliente;
       	rp.day_birth = aux.items[0].personal_fecha_nacimiento_cliente;
        rp.comuna = aux.items[0].personal_comuna_desc;
        rp.no_movil = aux.items[0].personal_telefono_celular;
        rp.domicilio = aux.items[0].personal_direccion_calle;
        rp.domicilio_num = aux.items[0].personal_direccion_numero;
        rp.home_type = aux.items[0].personal_tipo_vivienda_desc;
        if(aux.items[0].personal_apellido_materno_cliente == null){
            rp.last_Name_2 = '';
        }
        return rp;
    }
}