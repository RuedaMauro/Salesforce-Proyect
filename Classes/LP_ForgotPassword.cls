/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : Forgot Password Flow for User
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB

---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			11/06/2021		initial version
********************************************************************************/
global without sharing class LP_ForgotPassword {
    
    /**
*  @Description: Initialization of static variables
*  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        12/08/2021
*/
    private static final String MSG_PW_CHANGED;
    private static final String MSG_PW_ERROR;
    private static final String ERROR_CODE_01;
    private static final String ERROR_CODE_02;
    private static final String OTP_SEND;
    private static final String OTP_ERROR;
    
    /**
*  @Description: Initialization of static variables
*  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        26/04/2021
*/
    static {
        LP_ErrorMessageSelector msg = new LP_ErrorMessageSelector();
        List<LP_Mensaje_Sitio_Privado__mdt> meta = new List<LP_Mensaje_Sitio_Privado__mdt>();

        meta = msg.selectByLabel('LP_ErrorRecupero');
        MSG_PW_ERROR = meta[0].LP_Mensaje__c;

        MSG_PW_CHANGED = 'Contraseña cambiada con éxito';
        ERROR_CODE_01 = 'El RUT ingresado no tiene cuenta creada, ingresa a "Crear Cuenta"';
        ERROR_CODE_02 = 'El RUT ingresado no se encuentra en nuestros registros. Para consultas llámanos al 600 391 3000';
        OTP_SEND = 'Mensaje reenviado';
        OTP_ERROR = 'ERROR AL ENVIAR CODIGO OTP';
    }
    
    /**
*  @Description: Changes password to client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        14/06/2021  
*/
    @AuraEnabled
    public static LP_Response forgotPassword(String rutdv, String password){
        LP_Response rp = new LP_Response();
        List<User> user = getUserId(rutdv);
        Id userid;
        if(user.size() != 0){
            userid = user[0].id;
        }
        try{
            if(userid != null){
                unblockAccount(rutdv);
                setPassword(userId, password);
                rp.loginOK = true;
                rp.message = MSG_PW_CHANGED;
                return rp;
            }
            else{
                rp.loginOK = false;
                rp.message = MSG_PW_ERROR;
                return rp;
            }
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, MSG_PW_ERROR, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }
    
    
    /**
*  @Description: Verifies if the client has a credit account and obtains phone, email and name.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response ValidateAccount(String rutdv){
        LP_Response rp = new LP_Response();
        LP_Response rpaux = new LP_Response();
        List<String> split = LP_ForgotPassword.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        Integer rut = Integer.valueOf(split[0]);
        String dv = split[1];
        try{
            rp = LP_ClientCreditValidator.creditClientValidatorCall(rut, dv);
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, ERROR_CODE_02, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        try{
            if(rp.creditClient){
                //if(rp.creditClient){
                    String username = existingAccount(rutdv);
                    if(username != 'null'){
                        rpaux = LP_DemographicClientCall.demographicClientCall(rp);
                        rp.last_Name_1 = rpaux.last_Name_1;
                        rp.last_Name_2 = rpaux.last_Name_2;
                        rp.name = rpaux.name;
                        rp.email = rpaux.email;
                        rp.no_movil = rpaux.no_movil;
                        rp.code = LP_OTPValidator.OTP_Code(rp);
                        rp.loginOK = true;
                    }
                    else{
                        rp.message = ERROR_CODE_01;
                        rp.loginOK = false;
                        return rp;
                    }    	
            }
            else{
                rp.message = ERROR_CODE_01;
                    rp.loginOK = false;
                    return rp;
            }
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, MSG_PW_ERROR, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        return rp;
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
    
    /**
*  @Description: Verifies if client has an existing account on Salesforce and returns username.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static String existingAccount(String rutdv){
        LP_UsersSelector u=new LP_UsersSelector();
        List<User> users = u.selectByRutWithLimit(rutdv);
        if(users.size() == 0){
            return 'null';
        }
        else{
            return(users[0].username);           
        } 
    }
    
    /**
*  @Description: Verifies if client has an existing account on Salesforce and returns username.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static List<User> getUserId(String rutdv){
        LP_UsersSelector u=new LP_UsersSelector();
        List<User> users = new List<User>();
        users =u.selectByRutWithLimit(rutdv);
        return users;
    }
    
    /**
*  @Description: Verifies if client has an existing account on Salesforce and returns username.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static LP_Response ResendOTP(String rutdv, String no_movil){
        LP_Response rp = new LP_Response();
        List<String> split = LP_ForgotPassword.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        rp.no_movil = no_movil;
        try{
            rp.code = LP_OTPValidator.OTP_Code(rp);
            rp.message = OTP_SEND;
            rp.loginOK = true;
            return rp;
        }
        catch(Exception e){
            /*e.setMessage(OTP_ERROR);
LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
throw new AuraHandledException (JSON.serialize(data));*/
            rp.message = OTP_ERROR;
            return rp;
        }
    }
    
    /**
*  @Description: Check if Client password its blocked. Returns true if its blocked.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/06/2021  
*/
    @AuraEnabled
    public static boolean validateBlockedPassword(String rutdv){
        LP_UsersSelector u=new LP_UsersSelector();
        List<User> users = u.selectByRutWithLimit(rutdv); //[select Is_Blocked__c, Blocked_Time__c from User where RUT__c = :rutdv];
        if(users.size() != 0){
            if(users[0].Is_Blocked__c){
                if(users[0].Blocked_Time__c != null){
                    if(users[0].Blocked_Time__c.addDays(1) < System.now()){
                        return false;
                    }
                    else{
                        return true;
                    }
                }
                else{
                    return false;
                }
            }
            else{
                if(users[0].Blocked_Time__c != null){
                    if(users[0].Blocked_Time__c.addDays(1) < System.now()){
                        return false;
                    }
                    else{
                        return true;
                    }
                }
            }
            return false;
        }
        return false;
    }
    
    /**
*  @Description: Verifies if client has an existing account on Salesforce.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static void setPassword(Id userId, String password){
        System.setPassword(userId, password);
    }
    
    /**
*  @Description: Unblocks client after password recovery
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        12/08/2021
*/
    @AuraEnabled
    public static LP_Response unblockAccount(String rutdv){
        LP_UsersSelector u=new LP_UsersSelector();
        LP_Response rp = new LP_Response(); 
        List<User> users =  u.selectByRutWithLimit(rutdv);
        if(users.size() != 0){
            User user = users[0];
            UserLogin ul = [select id, IsPasswordLocked from UserLogin where UserId =: user.Id Limit: 1];
			ul.IsPasswordLocked = false;
            update(ul);
            rp.loginOK = true;
        }
        else{
            rp.loginOK = false;
        }
        return rp;
    }
}