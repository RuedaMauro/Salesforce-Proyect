/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 27/07/2021
Description  : Obtains data for Payment section.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			27/07/2021		initial version
********************************************************************************/
public with sharing class LP_PaymentController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String MSG_BLOCKED;
    private static final String RQ_AUTH;
    private static final String RQ_TOKEN;
    private static final String RQ_CONTENT;
    private static final String RQ_CONTENTTYPE;
    private static final String RQ_ENDPOINT;
    private static final String RQ_METHOD;
    private static final String RQ_CONTENTTYPE_PARAM;
    private static final String RQ_REMOTE_ID;
    private static final String RQ_REMOTE_ID_CONSUM;
    private static final String RQ_DESCRIPTION_CONSUM;
    private static final String RQ_DESCRIPTION_ITEM;
    
    
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
    	RQ_AUTH = 'Authorization';
    	RQ_TOKEN = [SELECT Authorization_Upago_Token__c FROM OSF_Endpoints__mdt].Authorization_Upago_Token__c;
        RQ_CONTENTTYPE_PARAM = 'application/json';
        RQ_ENDPOINT = [SELECT Upago_Url__c FROM OSF_Endpoints__mdt].Upago_Url__c;
        RQ_CONTENTTYPE = 'Content-Type';
        RQ_METHOD = 'POST';
        RQ_REMOTE_ID = 'CARD-VISA';
        RQ_DESCRIPTION_CONSUM = 'LaPolar VISA';
        RQ_REMOTE_ID_CONSUM = 'PAYMENT';
        RQ_DESCRIPTION_ITEM = 'Pago EECC';
    }
    
    /**
*  @Description: Get refinanciation Data from client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        02/08/2021  
*/
    @AuraEnabled
    public static LP_Response getRefinanciationData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId()); //[SELECT Id,Rut__c FROM User WHERE Id =:UserInfo.getUserId()];
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 220 data
        try{
            rp = LP_RenegClientData.renegClientDataCall(rp);
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
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
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 231 data
        try{
            rp = LP_GetPaymentHistory.GetPaymentHistory(rp);
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Get Refinantiation simulation Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response getSimulationData(Map<String, String> rpm, Integer cuotas){
        LP_Response rp = new LP_Response();
        //API 221 data
        try{
            rp = LP_GetSimulationData.getSimulationData(rpm, cuotas);
            String rutdv = rpm.get('rut') + '-' + rpm.get('dv');
            LP_Refinanciamiento__c ref = new LP_Refinanciamiento__c();
            ref.LP_MontoRefinanciar__c = Integer.valueOf(rp.imptotalL1);
            ref.LP_Cuotas__c = cuotas;
            ref.LP_MontoCuota__c = Integer.valueOf(rp.impcuotaL1);
            LP_AccountsSelector a= new LP_AccountsSelector();
            Account acc = new Account();
            acc = a.selectPersonAccountByRut(rutdv);
            //Account acc = accs[0];
            ref.LP_NombreCuenta__c = acc.id;//[Select id from Account where Vass_Rut__c =: rutdv Limit : 1].Id;
            insert(ref);
        }
        catch(Exception f){
            rp.message = f.getMessage() + f.getStackTraceString();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Get Refinantiation simulation Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response getPreSimulationData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId()); //[SELECT Id,Rut__c FROM User WHERE Id =:UserInfo.getUserId()];
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 220 data
        try{
            rp = LP_RenegClientData.renegClientDataCall(rp);
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }

/**
*  @Description: Get prepay Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response getCreditClientData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{
            rp = LP_ClientCreditValidator.CreditClientValidatorCall(Integer.valueOf(split.get(0)), split.get(1));
            
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }


/**
*  @Description: Get prepay Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response getBalanceData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 577 data
        try{
            rp = LP_GetBalanceData.getBalanceDataCall(rp);
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }


/**
*  @Description: Get prepay Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response getDebtData(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        try{
            rp = LP_GetDebtPayment.GetDebtPaymentDataCall(rp);
        }
        catch(Exception e){
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
    
    /**
*  @Description: Get prepay Data.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        28/07/2021  
*/
    @AuraEnabled
    public static LP_Response sendPayRequest(String email, Integer amount){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId());
        String rutdv = users[0].Rut__c;
        List<String> split = LP_PaymentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //Armado JSON request
        LP_JSONPayTranRequest rq = new LP_JSONPayTranRequest();
        rq.transactionId = rp.rut + rp.dv + String.valueOf(DateTime.now().getTime());
        rq.amount = amount;
        //Customer
        rq.Customer.remoteId = rutdv;
        rq.Customer.name = 'La Polar Client';
        rq.Customer.nationalId = rutdv;
        rq.Customer.email = email;
        rq.Customer.mobile = '';
        //Consumptions
        LP_JSONPayTranRequest.Consumptions consum = new LP_JSONPayTranRequest.Consumptions();
        consum.remoteId = RQ_REMOTE_ID;
        consum.description = RQ_DESCRIPTION_CONSUM;
        LP_JSONPayTranRequest.items items = new LP_JSONPayTranRequest.items();
        items.remoteId = rq.transactionId;
        items.description = RQ_DESCRIPTION_ITEM;
        items.amount = amount;
        consum.items = new List<LP_JSONPayTranRequest.items>();
        consum.items.add(items);
        rq.consumptions.add(consum);
        String rqs = LP_JSONPayTranRequest.serialize(JSON.serialize(rq));
        // Request Build
        HttpRequest req = new HttpRequest();
        req.setEndPoint(RQ_ENDPOINT);
        req.setMethod(RQ_METHOD);
        req.setHeader(RQ_AUTH, 'Bearer ' + RQ_TOKEN);
        req.setHeader(RQ_CONTENTTYPE, RQ_CONTENTTYPE_PARAM);
		req.setBody(rqs);
        //sending request.
        Http newHttp = new Http();
        HttpResponse res;
        
        try{
        res = newHttp.send(req);
        rp.message = String.valueOf(res);
        String rsp = res.getBody();
        LP_JSONPayTranResponse resp = (LP_JSONPayTranResponse)JSON.deserialize(rsp , LP_JSONPayTranResponse.class);
        createPaymentObject(rq.transactionId, resp.token, rutdv);
        rp.URL = resp.url;
        rp.token = resp.token;
        }
        catch(Exception f){
			LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(f ,MSG_ERROR, true);
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
*  @Description: Insert object por payment result.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        08/07/2021  
*/
    public static void createPaymentObject(String transactionId, String uniqueToken, String rutNumber) {
        OSF_Payment_Object__c newPayment = new OSF_Payment_Object__c();
        newPayment.Transaction_Token__c =  uniqueToken;
        newPayment.Transaction_Id__c =  transactionId;
        newPayment.Rut_Number__c =  rutNumber;
        Database.insert(newPayment);
    }

}