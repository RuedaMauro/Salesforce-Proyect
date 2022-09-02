/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : Get Data in order to verifie if client's card has a pin created or not.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_getCreatedPinInformation {
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String RQ_BLOCK_CODE;
    private static final String RQ_UNBLOCK_CODE;
    private static final String RQ_PIN_CREATED;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        RQ_BLOCK_CODE = '77';
        RQ_UNBLOCK_CODE = '0';
        RQ_PIN_CREATED = '5';
    }
    
    /**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response getCreatedPinInformationCall(LP_Response rp){
            LP_Aoe68Call call = new LP_Aoe68Call(rp.tarjetaEmitidaPan, rp.centalta);
            String rsp = call.call().getBody();
            LP_JSONAoe68Response aux = (LP_JSONAoe68Response)JSON.deserialize(rsp , LP_JSONAoe68Response.class);
            if(aux.items[0].indsittar == RQ_PIN_CREATED){
                rp.createdPin = true;
            }
            else{
                rp.createdPin = false;
            }
            if(aux.items[0].codBlq == RQ_BLOCK_CODE){
                rp.blockCard = true;
            }
            else{
                if(aux.items[0].codBlq == RQ_UNBLOCK_CODE){
                    rp.blockCard = false;
                }
                else{
                    rp.blockCard = true;
                }
            }
            return rp;
        }
    
    /**
	*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
	*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
	*  @Date:        11/06/2021  
	*/
    @AuraEnabled
    public static LP_Response getBloquedCardData(LP_Response rp){
        for(Integer i = 0; i < rp.aditionals.size(); i++){
            LP_Aoe68Call call = new LP_Aoe68Call(rp.aditionals[i].pan, rp.aditionals[i].centalta);
            String rsp = call.call().getBody();
            LP_JSONAoe68Response aux = (LP_JSONAoe68Response)JSON.deserialize(rsp , LP_JSONAoe68Response.class);
            rp.aditionals[i].codBlq = Integer.valueOf(aux.items[0].codblq);
        }
        return rp;
    }
}