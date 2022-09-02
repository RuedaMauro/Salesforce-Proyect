/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 12/07/2021
Description  : Obtains data from my card section.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			12/07/2021		initial version
********************************************************************************/
public with sharing class LP_getCreditCardInformation {
    /**
    *  @Description: Makes the call and obtain credit client data of the client.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021  
    */
    public static LP_Response CreditCardInformationCall(LP_Response rp){
            LP_Aoe1233Call call = new LP_Aoe1233Call(rp.rut, rp.dv, rp.tarjetaEmitidaPan);
            String rsp = call.call().getBody();
            LP_JSONAoe1233Response aux = (LP_JSONAoe1233Response)JSON.deserialize(rsp , LP_JSONAoe1233Response.class);
            rp.tarjetaCod = aux.Items[0].tarjetaCod;
            rp.name = aux.Items[0].clienteNombreCompleto;
            rp.codTar = aux.items[0].registros.codTar;
            rp.fechaVencTarjeta = (aux.items[0].tarjetaVencM + '/' +  aux.items[0].tarjetaVencA.substring(2,4));
            return rp;
    }
}