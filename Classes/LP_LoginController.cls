/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Login Validation
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			10/06/2021		initial version
********************************************************************************/
global without sharing class LP_LoginController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String BLOCK_CODE_01;
    private static final String BLOCK_CODE_08;
    private static final String ERROR_CODE_01;
    private static final String ERROR_CODE_02;
    private static final String ERROR_CODE_03;
    private static final String ERROR_CODE_04;
    private static final String ERROR_CODE_05;
    private static final String ERROR_CODE_GENERIC;
    private static final String ERROR_CODE_BLOCKED;
    private static final String WELCOME_CODE_GENERIC;
    private static final String USER_NOT_FOUND;
    private static final String NOT_FOUND;
    private static final String ERROR_PW_INCORRECT;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        
        LP_ErrorMessageSelector msg = new LP_ErrorMessageSelector();
        List<LP_Mensaje_Sitio_Privado__mdt> meta = new List<LP_Mensaje_Sitio_Privado__mdt>();
        
        BLOCK_CODE_01 = '01 CLIENTE FALLECIDO';
        BLOCK_CODE_08 = '08 CARTERA CASTIGADA';
        
        meta = msg.selectByLabel('LP_CarteraBloqueada');
        ERROR_CODE_01 = meta[0].LP_Mensaje__c;
        
        meta = msg.selectByLabel('LP_CuentaBloqueada');
        ERROR_CODE_BLOCKED = meta[0].LP_Mensaje__c;
        
        meta = msg.selectByLabel('LP_CuentaInexistente2');
        ERROR_CODE_02 = meta[0].LP_Mensaje__c;
        
        meta = msg.selectByLabel('LP_CuentaInexistente');
        ERROR_CODE_03 = meta[0].LP_Mensaje__c;
        
        meta = msg.selectByLabel('LP_ContrasenaIncorrecta');
        ERROR_CODE_04 = meta[0].LP_Mensaje__c;
        
        meta = msg.selectByLabel('LP_ErrorGenerico');
		ERROR_CODE_GENERIC = meta[0].LP_Mensaje__c;
        
        ERROR_CODE_05 = 'Password bloqueada';        
        WELCOME_CODE_GENERIC = 'Bienvenido ';
        USER_NOT_FOUND = 'Usuario no encontrado';
        NOT_FOUND = 'Not Found';
        ERROR_PW_INCORRECT = 'LP_RestConnectionWithAuth.ServiceException';
    }
    
    /***  
	*  @Description: Validates if rut and password on the login screen is valid and have permissions to
	enters to private site.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
	*  @Date:        10/06/2021         
	*/
    @AuraEnabled
    public static LP_Response loginValidation(String rutdv, String password){
        List<String> split = LP_LoginController.getRutDv(rutdv);
        LP_Response rpaux;
        LP_Response rp = new LP_Response();
        rp.rut = Integer.valueOf(split.get(0));
        rp.dv = split.get(1);
        String username = existingAccount(rutdv);
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(rp.rut, rp.dv);
            if(rp.creditClient){
                if(username != 'null'){
                    if(!validateBlockedPassword(rutdv)){
                        rpaux = LP_BlockedClientValidator.blockClientValidatorCall(rp);
                        rp.blockCode = rpaux.blockCode;
                        if(blockCodeValidator(rp.blockCode)){ 
                            rp.message = ERROR_CODE_01;    
                            return rp;                 
                        }
                        else{
                            rp = goLogin(rp, password, username);
                            return rp;
                        }
                    }
                    else{
                        rp.message = ERROR_CODE_BLOCKED;
                        rp.userBlocked = true;
                        return rp;
                    }
                }
                else{
                    rp.message = ERROR_CODE_02;
                    return rp;
                }
            }
            else{
                rp.message = ERROR_CODE_03;
                return rp;
            }
        }
        catch(Exception e){
            if(e.getMessage() == NOT_FOUND){
                rp = goLogin(rp, password, username);
                return rp;
            }
            else if(e.getTypeName() == ERROR_PW_INCORRECT){
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, ERROR_CODE_02, true);
				throw new AuraHandledException (JSON.serialize(data));
            }
            else{
				LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, ERROR_CODE_04, true);
				throw new AuraHandledException (JSON.serialize(data));
            }
        }
    }
    
/**
*  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
	and dv separately.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/06/2021  
*/
    @AuraEnabled
    public static LP_Response goLogin(LP_Response rp, String password, String username){
        String rutdv = String.valueOf(rp.rut) + '-' + rp.dv;
        LP_Response rpaux = new LP_Response();
        try{
            PageReference pr = Site.login(username, password, null);
            if(pr != null){
                rp.loginOK = true;
                rp.URL = pr.getURL();
                rp.message = WELCOME_CODE_GENERIC + rp.name;         
            }
            else{
                rp.loginOK = false;
                rp.incorrectPassword = true;
                rp.message = 'asd';
                return rp;
            }
            return rp;
        }
        catch(Exception f){
                if(validateBlockedPassword(rutdv)){
                    LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(f,ERROR_CODE_05 , true); 
					throw new AuraHandledException (JSON.serialize(data));
                }
                else{
                    LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(f,ERROR_CODE_04 , true); 
					throw new AuraHandledException (JSON.serialize(data));
                }
    }
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
*  @Description: Check if Client password its blocked. Returns true if its blocked.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/06/2021  
*/
    @AuraEnabled
    public static boolean validateBlockedPassword(String rutdv){
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users =l.selectByRutWithLimit(rutdv);
        if(users.size() != 0){
            User user = users[0];
            UserLogin ul = [select id, IsPasswordLocked from UserLogin where UserId =: user.Id Limit: 1];
            if(ul.IsPasswordLocked){
                return true;
            }
            else{
                return false;
            }
        }
        else{
            return true;
        }
    }

    /**
*  @Description: Verifies if client has an existing account on Salesforce.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        17/06/2021
*/
    @AuraEnabled
    public static String existingAccount(String rutdv){
        LP_UsersSelector l = new LP_UsersSelector();
        List<User> users = l.selectByRutWithLimit(rutdv); 
        if(users.size() == 0){
            return 'null';
        }
        else{
            return(users[0].username);           
        } 
    }
    
    /**
*  @Description: Blocks client account in case of three fails trys to login
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        22/06/2021
*/
    @AuraEnabled
    public static LP_Response blockAccount(String rutdv){
        LP_Response rp = new LP_Response(); 
        LP_UsersSelector l= new LP_UsersSelector();
        List<User> users =l.selectByRutWithLimit(rutdv);
        if(users.size() != 0){
            User user = users[0];
            user.Is_Blocked__c = true;
            user.Blocked_Time__c = system.now();
            update(user);
            rp.loginOK = true;
            rp.message = ERROR_CODE_BLOCKED;
        }
        else{
            rp.message = USER_NOT_FOUND;
            rp.loginOK = false;
        }
        return rp;
    }
    
    /**
*  @Description: Validates block code
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        22/06/2021
*/
    @AuraEnabled
    public static Boolean blockCodeValidator(String blockCode){
        if(blockCode == BLOCK_CODE_01){ 
            return true;                
        }
        else{
            if(blockCode == BLOCK_CODE_08){
                return true;
            }
            else{
                return false;
            }
        }
    }
    
}