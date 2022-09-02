/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 14/06/2021
Description  : Home Controller Class
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB

---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			14/06/2021		initial version
********************************************************************************/
public with sharing class LP_HomeController {
    
    private static final String MSG_CONGRATS;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static { 
        MSG_CONGRATS = 'Obtención de datos correcta';
    }
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static LP_Response getHomeData1(){
    	LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_HomeController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
     	
        }
        catch(Exception e){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getMessage() + e.getStackTraceString(), true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static LP_Response getHomeData2(){
    	LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_HomeController.getRutDv(rutdv);
        //API 577 data
        try{
            rp = LP_DemographicClientCall.demographicClientCall(rp);
        
        }
        catch(Exception e){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getMessage() + e.getStackTraceString(), true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static LP_Response getHomeData3(){
    	LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_HomeController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        try{
           
           rp = LP_GetBalanceData.getBalanceDataCall(rp);
          
        }
        catch(Exception e){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getMessage(), true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static LP_Response getHomeData4(){
    	LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_HomeController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{   
            rp = LP_GetDebtPayment.GetDebtPaymentDataCall(rp);
        }
        catch(Exception e){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getMessage() + e.getStackTraceString(), true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static LP_Response getHomeData5(){
    	LP_Response rp = new LP_Response();
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users = l.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_HomeController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{
           rp = LP_RenegClientData.renegClientDataCall(rp);
        }
        catch(Exception e){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getMessage() + e.getStackTraceString(), true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        rp.message = MSG_CONGRATS;
        return rp;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
  	@AuraEnabled
    public static LP_Response getUserInfo(){
        LP_Response r= new LP_Response();
        LP_UsersSelector a= new LP_UsersSelector();
        List<User> usr = a.selectByIdWithLimit(UserInfo.getUserId());
        LP_LoginHistorySelector lh=new LP_LoginHistorySelector();
        List<LoginHistory> logh= [select id, LoginTime from LoginHistory where UserId =:UserInfo.getUserId() order by LoginTime DESC];//lh.selectByUserIdWithLimit2(UserInfo.getUserId());
        r.name=usr[0].firstname;
        if(logh.size() > 1){
        r.lastLoginDate= logh[1].loginTime;
        r.LoginOK=true;
        }
        else{
         r.loginOK = false;   
        }
        return r;
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021  
    */
    @AuraEnabled
    public static List<String> getRutDv(String rut){
        List<String> str = rut.Split('-',2);
        return str;
    }
}