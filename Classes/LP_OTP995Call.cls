/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 14/06/2021
Description  : API IA-995 (OTP Message) Call
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			14/06/2021		initial version
********************************************************************************/
public with sharing class LP_OTP995Call {
	String rutdv;
    String no_movil;
    
    /**
    *  @Description: Constructor
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        14/06/2021         
    */
    public LP_OTP995Call(Integer rut, String dv, String no_movil){
        this.rutdv = (String.valueOf(rut) + dv);
        this.no_movil = no_movil;
    }
    
    /**
    *  @Description: API IA-995 (OTP Message) json mapping
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        14/06/2021  
    */
    private LP_JSONOTPRequest mapping() {
        LP_JSONOTPRequest otp = new LP_JSONOTPRequest();
        otp.body = new LP_JSONOTPRequest.Body();
        otp.body.cuotas = '';
        otp.body.montoTotal = '';
        otp.body.operationId = 'validacionOTP';
        otp.body.userEmail = '';
        otp.body.userId =  this.rutdv;
        otp.body.userPhone = '';
        if(this.no_movil != null){
            otp.body.userPhone = no_movil;
        }
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
        return objClass.callServiceWithTokenPrivateSite(setConf, JSON.serialize(mapping(), true));
    }
}