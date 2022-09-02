/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 
History      : Obtains OTP Code
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			14/06/2021		initial version 
********************************************************************************/
public with sharing class LP_OTPValidator {
    
    /**
*  @Description: Makes the call to obtain OTP Code.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static String OTP_Code(LP_Response rp){
        LP_OTP995Call call;
        call = new LP_OTP995Call(rp.rut, rp.dv, rp.no_movil);        
        String rsp = call.call().getBody();
        LP_JSONOTPResponse otp = (LP_JSONOTPResponse)JSON.deserialize(rsp , LP_JSONOTPResponse.class);
        String code = otp.items?.get(0).data;
        return code;
    }
}