/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 13/07/2021
Description  : Obtains data for my digital card section.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			13/07/2021		initial version
********************************************************************************/
public with sharing class LP_MyDigitalCardController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String MSG_SEND;
    
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
        MSG_SEND = 'Mensaje Reenviado';
    }
    
    /**
*  @Description: Get My card section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getMyCardData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());  
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyDigitalCardController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCallComplete(Integer.valueOf(split.get(0)), split.get(1));
            rp = LP_getCreditCardInformation.CreditCardInformationCall(rp);
        }
        catch(Exception e){
			e.setMessage(MSG_ERROR);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data)); 
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Get Card Pin Created Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getCreatedPinData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyDigitalCardController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
        }
        catch(Exception e){
			e.setMessage(MSG_ERROR);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data)); 
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Creates PIN.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        19/07/2021  
*/
    @AuraEnabled
    public static LP_Response CreatePin(String pan, String pin){
        LP_Response rp = new LP_Response();
        //API 966
        try{
            rp = LP_CreatePin.CreatePIN(pan, pin);
        }
        catch(Exception e){
            e.setMessage(MSG_ERROR);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data)); 
        }
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
    
    /**
*  @Description: Verifies if client has an existing account on Salesforce and returns username.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static LP_Response ResendOTP(Integer rut, String dv, String no_movil){
        LP_Response rp = new LP_Response();
        rp.rut = rut;
        rp.dv = dv;
        rp.no_movil = no_movil;
        try{
            rp.code = LP_OTPValidator.OTP_Code(rp);
            rp.message = MSG_SEND;
            rp.loginOK = true;
            return rp;
        }
        catch(Exception e){
            e.setMessage(MSG_ERROR);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data)); 
        }
    }
}