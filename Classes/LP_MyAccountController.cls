/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : Obtains data for my account section.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			01/06/2021		initial version
********************************************************************************/
public with sharing class LP_MyAccountController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String ERROR_CODE_01;
    
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
        ERROR_CODE_01 = 'Error Interno, por favor intente mas tarde.';
    }
    
    /**
*  @Description: Get My Account section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getMyAccountData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        try{
        //API 577 data
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
        //API 207 data
            rp = LP_GetBalanceData.getBalanceDataCall(rp);
        }
        catch(Exception e){
            e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
*  @Description: Get My Account section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getMyAccountBalanceData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = U.selectByIdWithLimit(UserInfo.getUserId()); 
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 207 data
        try{
            rp = LP_GetBalanceData.getBalanceDataCall(rp);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data)); 
        }
        rp.message = MSG_CONGRATS;
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
*  @Description: Get My Account Facturation section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getMyAccountDataFacturation(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = U.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        try{
        //API 577 data
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
        //API 212 data
            rp.facturationItems = LP_GetExpirationShareData.GetExpirationShareDataCall(rp);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.tarjetaCod = rp.facturationItems[0].montov;
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }  
    
    /**
*  @Description: Get My Account Facturation section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getMyAccountMovementsData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = U.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        rp.rut = Integer.valueof(split[0]);
        if(split[1] == 'k'){
            rp.dv = split[1].toUpperCase();
        }
        else{
            rp.dv = split[1];
        }
        try{
            rp = LP_getMovementsData.GetMovementsDataCall(rp);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }  
    
    /**
*  @Description: Get My Account Facturation section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getLastFacturationData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = U.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        rp.rut = Integer.valueof(split[0]);
        rp.dv = split[1];
        try{
            rp = LP_GetDebtPayment.GetDebtPaymentDataCall(rp);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }  
    
    /**
*  @Description: Get My Account Facturation section Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getClientTypeData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = U.selectByIdWithLimit(UserInfo.getUserId()); 
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        //API 577 data.
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    
     /**
*  @Description: Get My docs data section.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getDocs(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = [SELECT Id,Rut__c FROM User WHERE Id =:UserInfo.getUserId()];
        String rutdv = users[0].Rut__c;
        List<String> split = LP_MyAccountController.getRutDv(rutdv);
        rp.rut = Integer.valueof(split[0]);
        rp.dv = split[1];
        //API 214 data.
        try{
            rp = LP_getEECC.getEECC(rp);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Get My docs data section.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    @AuraEnabled
    public static LP_Response getDocument(String rut, String pan, String fecemi){
        LP_Response rp = new LP_Response();
        //API 215 data.
        try{
            rp = LP_getDoc.getDoc(rut, pan, fecemi);
        }
        catch(Exception e){
			e.setMessage(ERROR_CODE_01);
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));   
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
}