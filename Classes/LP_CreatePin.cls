/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 19/07/2021
Description  : It Provides methods in order to create pin.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			19/07/2021		initial version
********************************************************************************/
public with sharing class LP_CreatePin {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String RQ_MSG;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        RQ_MSG = 'Pin creado con éxito';
    }
    
    /**
*  @Description: Creates pin for client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response CreatePIN(String pan, String pin){
        LP_Response rp = new LP_Response();
        LP_Aoe966Call call = new LP_Aoe966Call(pan, pin);
        String rsp = call.call().getBody();
        LP_JSONAoe966Response aux = (LP_JSONAoe966Response)JSON.deserialize(rsp , LP_JSONAoe966Response.class);
        rp.message = 'Pin creado con éxito';
        rp.loginOK = true;
        return rp;
    }
    
}