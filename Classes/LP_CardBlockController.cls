/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : Card Block section controller.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_CardBlockController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String MSG_BLOCKED;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        
        LP_ErrorMessageSelector msg = new LP_ErrorMessageSelector();
        List<LP_Mensaje_Sitio_Privado__mdt> meta = new List<LP_Mensaje_Sitio_Privado__mdt>();
        
        meta = msg.selectByLabel('LP_ErrorGenerico');
        MSG_ERROR = meta[0].LP_Mensaje__c;
        
        MSG_CONGRATS = 'Obtención de datos correcta';
        MSG_BLOCKED = 'El bloqueo de tu tarjeta será solo temporal, puedes habilitarla para su uso desbloqueándola por el mismo medio. El bloqueo temporal te permitirá comprar en páginas web o en Tiendas La Polar a través de tu huella. Para bloqueo permanente, debes solicitarlo directamente en Tiendas La Polar o llamando a nuestro número telefónico 800 395 800.';
    }
    
    /**
*  @Description: Blocks Card.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        13/07/2021  
*/
    @AuraEnabled
    public static LP_Response getData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_CardBlockController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        try{
            rp = LP_getCreditCardList.getCreditCardList(Integer.valueOf(split.get(0)), split.get(1));
            rp = LP_getCreatedPinInformation.getBloquedCardData(rp);
        }
        catch(Exception e){
            rp.message = MSG_ERROR;
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Blocks Card.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        13/07/2021  
*/
    @AuraEnabled
    public static LP_Response blockCard(String pan){
        LP_Response rp = new LP_Response();
        rp.tarjetaEmitidaPan = pan;
        //API 225 Data
        try{
            rp = LP_CardBlock.blockCard(rp);
        }
        catch(Exception e){
            rp.message = MSG_ERROR;
            return rp;
        }
        rp.message =  MSG_BLOCKED;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Blocks Card.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        13/07/2021  
*/
    @AuraEnabled
    public static LP_Response unblockCard(String pan){
        //API 225 Data
        LP_Response rp = new LP_Response();
        rp.tarjetaEmitidaPan = pan;
        try{
            rp = LP_CardBlock.unblockCard(rp);
        }
        catch(Exception e){
            rp.message = MSG_ERROR;
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
and dv separately.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static List<String> getRutDv(String rut){
        List<String> str = rut.Split('-',2);
        return str;
    }
}