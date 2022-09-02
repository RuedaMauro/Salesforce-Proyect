/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 14/06/2021
Description  : Create account Flow for User
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB

---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			14/06/2021		initial version
********************************************************************************/
public without sharing class LP_CreateAccount {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String RQ_ALIAS;
    private static final String RQ_TIMEZONESIDKEY;
    private static final String RQ_LOCALESIDKEY;
    private static final String RQ_EMAILENCODING;
    private static final String RQ_LANGUAGELOCALEKEY;
    private static final String PROFILE_NAME;
    private static final String EMAIL_TEMPLATE;
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String MSG_RUT_NOT_FOUND;
    private static final String MSG_EXISTING_RUT;
    
     /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        LP_ErrorMessageSelector msg = new LP_ErrorMessageSelector();
        List<LP_Mensaje_Sitio_Privado__mdt> meta = new List<LP_Mensaje_Sitio_Privado__mdt>();

        meta = msg.selectByLabel('LP_ErrorCreacion');
        MSG_ERROR = meta[0].LP_Mensaje__c;

        RQ_ALIAS = 'alias1';
        RQ_TIMEZONESIDKEY = 'America/Santiago';
        RQ_LOCALESIDKEY = 'en_US';
    	RQ_EMAILENCODING = 'ISO-8859-1';
        RQ_LANGUAGELOCALEKEY = 'en_US';
        PROFILE_NAME = 'Customer Community User Sitio Privado';
        EMAIL_TEMPLATE = 'lapolar@lapolar.com';
        MSG_RUT_NOT_FOUND = 'El rut ingresado no se encuentra en nuestros registros. Para consultas llámanos al 600 391 3000';
    	MSG_EXISTING_RUT = 'Según nuestros registros, el Rut ingresado ya posee una cuenta.';
    }
    
    /**
    *  @Description: Create a account user community
    *  @Author:      Damian Biaggio
    *  @Date:        23/07/2021  
    */
    @AuraEnabled
    public static LP_Response CreateAccount(Map<String,String> params){
                                                LP_Response rp = new LP_Response();
                                                String rutdv = (String.valueOf(params.get('rut') + '-' + params.get('dv')));
                                                User user = new User();
                                                Profile pro = [Select id from Profile where name = :PROFILE_NAME];
                                                Account acc1 = new Account();
                                                acc1 = existingAcc(rutdv);
                                                try{
                                                    if(acc1 == null){
                                                    acc1 = new Account();
                                                    acc1.FirstName = params.get('name');
                                                    acc1.LastName = params.get('last_Name_1') + ' ' + params.get('last_Name_2');
                                                    acc1.Vass_Rut__c = rutdv;
                                                    acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
                                                    acc1.LP_CuentaCreadaSitios__pc = true;
                                                    insert (acc1);
                                                    }
                                                    user.FirstName = params.get('name');
                                                    user.LastName = params.get('last_Name_1') + ' ' + params.get('last_Name_2');
                                                    user.IsActive = true;
                                                    if(params.get('email') != '-'){
                                                       user.Email = params.get('email');
                                                    }
                                                   else{
                                                        user.Email = EMAIL_TEMPLATE;
                                                    }
                                                    user.Username = user.Email + '.LaPolar2' + rutdv;
                                                    user.CommunityNickname = user.Email +'2' + rutdv;
                                                    user.ProfileId = pro.id;            
                                                    LP_ContactSelector c= new LP_ContactSelector();
                                                    List<Contact> contct = c.selectByAccountIdWithLimit(acc1.Id);
                                                    Contact cont=contct[0];
                                                    user.ContactId = cont.Id;
                                                    user.Phone = params.get('no_movil');
                                                    user.RUT__c = (params.get('rut') + '-' + params.get('dv'));
                                                    user.Alias = RQ_ALIAS;
                                                    user.TimeZoneSidKey = RQ_TIMEZONESIDKEY;
                                                    user.LocaleSidKey = RQ_LOCALESIDKEY;
                                                    user.EmailEncodingKey = RQ_EMAILENCODING;
                                                    user.LanguageLocaleKey = RQ_LANGUAGELOCALEKEY; 
                                                    Site.createExternalUser(user, acc1.Id, params.get('password'), false);
                                                }
                                                catch(Exception e){
                                                    LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e,MSG_ERROR, true);
													throw new AuraHandledException (JSON.serialize(data));
                                                }                                        
                                                rp.message = MSG_CONGRATS;
                                                rp.loginOK = true;
                                                return rp;
                                            }

    /**
    *  @Description: Verifies if the client is a credit client and obtains phone, email and name.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        14/06/2021  
    */
    @AuraEnabled
    public static LP_Response validateAccount(String rutdv){
        LP_Response rpaux;
        LP_Response rp = new LP_Response();
        List<String> split = LP_CreateAccount.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        Integer rut = Integer.valueOf(split[0]);
        String dv = split[1];
        try{
        rp = LP_ClientCreditValidator.creditClientValidatorCall(rut, dv);
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, MSG_RUT_NOT_FOUND, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        if(rp.creditClient){
            rp.existingAccount = (existingAccount(rutdv));
            if(rp.existingAccount){
                rp.message = MSG_EXISTING_RUT;
                rp.loginOK = false;
                return rp;
            }
        try{
            rpaux = LP_DemographicClientCall.demographicClientCall(rp);
            rp.last_Name_1 = rpaux.last_Name_1;
            rp.last_Name_2 = rpaux.last_Name_2;
            rp.name = rpaux.name;
            rp.no_movil = rpaux.no_movil;
            rp.code = LP_OTPValidator.OTP_Code(rp);
            }
            catch(Exception e){
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, e.getStackTraceString(), true);
                throw new AuraHandledException (JSON.serialize(data));
            }
            rp.loginOK = true;
        }
        else{
            rp.message = MSG_RUT_NOT_FOUND;
        	rp.loginOK = false;
            return rp;		
        }
        return rp;
    }
    
       
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        14/06/2021  
    */
    @AuraEnabled
    public static List<String> getRutDv(String rut){
        List<String> str = rut.Split('-',2);
        return str;
    }
    
    /**
    *  @Description: Verifies if client has an existing account on Salesforce.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        17/06/2021
    */
	@AuraEnabled
    public static boolean existingAccount(String rutdv){
        LP_UsersSelector userSel = new LP_UsersSelector();
        List<User> users = userSel.selectByRutWithLimit(rutdv);
        if(users.size() == 0){
            return false;
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
    @future @AuraEnabled
    public static void setPassword(Id userId, String password){
        System.setPassword(userId, password);
    }
    
    /**
    *  @Description: Verifies if client has an existing account on Salesforce and returns username.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        17/06/2021
    */
    @AuraEnabled
    public static LP_Response ResendOTP(String rutdv, String no_movil){
        LP_Response rp = new LP_Response();
        List<String> split = LP_CreateAccount.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        rp.no_movil = no_movil;
        try{
        	rp.code = LP_OTPValidator.OTP_Code(rp);
        	rp.loginOK = true;
            return rp;
        }
        catch(Exception e){
        	rp.message = MSG_ERROR;
        	rp.loginOK = false;
            return rp;
        }
    }
    
    /**
    *  @Description: Split Rut and dv because we have the rut as "1234567-k" and API Calls needs rut
    and dv separately.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        14/06/2021  
    */
    public static Account existingAcc(String rutdv){
        LP_AccountSSelector accSelector = new LP_AccountsSelector();
        List<Account> accId = accSelector.selectByRutInAList(rutdv);
        if(accId.size() > 0){
            return accid[0];
        }
        else{
        	return null;       
        }
    }
    
}