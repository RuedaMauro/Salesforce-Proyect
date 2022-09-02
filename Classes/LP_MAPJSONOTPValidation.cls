/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Class for OTP validation mapping
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
Rodrigo Salinas Oye			RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			17/05/2021		initial version
1.1      RSO			06/07/2021		Add Constructor for Phone flag
********************************************************************************/
public with sharing class LP_MAPJSONOTPValidation {

    private Lead objLead;
    private Boolean isPhone;

    /**
    *  @Description: Constructor
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021         
    */
    public LP_MAPJSONOTPValidation(Lead objLead) {
        this.objLead = objLead;
        isPhone = false;
    }

    /**
    *  @Description: Constructor
    *  @Author:      Rodrigo Salinas Oye, Deloitte, atejoso@deloitte.com
    *  @Date:        06/07/2021         
    */
    public LP_MAPJSONOTPValidation(Lead objLead, Boolean isSentByPhone) {
        this.objLead = objLead;
        isPhone = isSentByPhone;
    }

    /**
    *  @Description: OTP validation json mapping
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    private LP_JSONOTPRequest mapping() {
        LP_JSONOTPRequest otp = new LP_JSONOTPRequest();
        otp.body = new LP_JSONOTPRequest.Body();
        otp.body.cuotas = '';
        otp.body.montoTotal = '';
        otp.body.operationId = 'OTPOB';
        otp.body.userId =  objLead.LP_Rut__c.replace('-','');//'131188242'; //userId;
        otp.body.userEmail = isPhone == false ? objLead.Email : '';
        otp.body.userPhone = isPhone == true ? objLead.MobilePhone : '';
        otp.header = new LP_JSONHeaderRequest();
        otp.header.commerce = 'RF';
        otp.header.country = 'CL';
        otp.header.channel = 'CRM';
        return otp;
    }
    
    /**
    *  @Description: Call to service to get OTP code
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    public HttpResponse call() {
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'ValidacionOTP');
        return objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true));
    }
}