/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : Verifies if Client is a credit client
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
public with sharing class LP_ClientCreditValidator {
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String VISA_CLIENT;
    private static final String Visam_CLIENT;
    private static final String TLPSAT_CLIENT;
    private static final String TLPMEN_CLIENT;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        VISA_CLIENT = 'VISA';
        Visam_CLIENT = 'visa';
        TLPSAT_CLIENT = 'TLPSAT';
        TLPMEN_CLIENT = 'TLPMEN';
    }
    
    /**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response creditClientValidatorCall(Integer rut, String dv){
        LP_Response rp = new LP_Response();
        LP_Aoe577Call call = new LP_Aoe577Call(rut, dv);
        rp.rut = rut;
        rp.dv = dv;
        String rsp = call.call().getBody();
        LP_JSONAoe577Response aux = (LP_JSONAoe577Response)JSON.deserialize(rsp , LP_JSONAoe577Response.class);
        
        rp.cuenta = aux.items[0].clienteCuenta;
        rp.name = aux.items[0].clienteNombreCompleto;
        rp.centalta = aux.items[0].clienteCentroAlta;
        rp.tarjetaEmitidaPan = aux.items[0].tarjetaEmitidaPan.substring(12,16);
        rp.tarjetaCod = aux.items[0].tarjetaCod;
        
        if(verifyClient(aux.items[0].tarjetaCod)){               
            rp.creditClient = true;
        }
        else{
            rp.creditClient = false;
        }
        if(verifyVisaClient(aux.items[0].tarjetaCod)){
            rp.VisaClient = true;
        }
        else{
            rp.VisaClient = false;
        }
        return rp;
    }
    
     /**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response creditClientValidatorCallComplete(Integer rut, String dv){
        LP_Response rp = new LP_Response();
        LP_Aoe577Call call = new LP_Aoe577Call(rut, dv);
        rp.rut = rut;
        rp.dv = dv;
        String rsp = call.call().getBody();
        LP_JSONAoe577Response aux = (LP_JSONAoe577Response)JSON.deserialize(rsp , LP_JSONAoe577Response.class);
        
        rp.cuenta = aux.items[0].clienteCuenta;
        rp.name = aux.items[0].clienteNombreCompleto;
        rp.centalta = aux.items[0].clienteCentroAlta;
        rp.tarjetaEmitidaPan = aux.items[0].tarjetaEmitidaPan;
        rp.tarjetaCod = aux.items[0].tarjetaCod;
        
        if(verifyClient(aux.items[0].tarjetaCod)){               
            rp.creditClient = true;
        }
        else{
            rp.creditClient = false;
        }
        if(verifyVisaClient(aux.items[0].tarjetaCod)){
            rp.VisaClient = true;
        }
        else{
            rp.VisaClient = false;
        }
        return rp;
    }
    
        /**
*  @Description: Verifies VISA or TLP Client
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static boolean verifyClient(String client){
    	if(client == VISA_CLIENT || client == Visam_CLIENT ||  client == TLPSAT_CLIENT || client == TLPSAT_CLIENT){
            return true;
    	}
        else{
            return false;
        }
    }
    
     /**
*  @Description: Verifies VISA Client
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static boolean verifyVisaClient(String client){
    	if(client == VISA_CLIENT || client == Visam_CLIENT){
            return true;
    	}
        else{
            return false;
        }
    }
}