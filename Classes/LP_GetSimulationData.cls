/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 28/07/2021
Description  : Obtains Renegotiation Simulation API Call Data.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			28/07/2021		initial version
********************************************************************************/
public with sharing class LP_GetSimulationData {
    
    /**
*  @Description: Makes the call and obtain demographic data of the client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    public static LP_Response getSimulationData(Map<String,String> rpm, Integer cuotas){
        LP_Response rp = new LP_Response();
        LP_Aoe221Call.bodyRequest rq = new LP_Aoe221Call.bodyRequest();
        rq.deuda_avance = rpm.get('deudaavance');
        rq.deuda_avancexl = rpm.get('deudaavancexl');
        rq.deuda_compra = rpm.get('deudacompra');
        rq.deuda_renegociar = rpm.get('deudatotal_r');
        rq.dias_mora = rpm.get('dias_mora');
        rq.rut = rpm.get('rut') + '-' + rpm.get('dv');
        rq.tasa = rpm.get('tasa');
        rq.tipofact1 = rpm.get('tipofac');
        rq.tipofact3 = rpm.get('tipofac3');
        LP_Aoe221Call call = new LP_Aoe221Call(rq, cuotas);       	
        String rsp = call.call().getBody();        	
        LP_JSONAoe221Response aux = (LP_JSONAoe221Response)JSON.deserialize(rsp , LP_JSONAoe221Response.class);
        rp.imptotalL1 = aux.items[0].imptotalL1;
        rp.impcuotaL1 = aux.items[0].impcuotaL1;
        return rp;
    }
}