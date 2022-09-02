/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 23/07/2021
Description  : REST service login validation for external transaction usage
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			23/07/2021		initial version
1.0      ATO			05/08/2021		refactoring
********************************************************************************/
@RestResource(urlMapping='/V2/LoginValidation')
global without sharing class LP_LoginValidation {

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    private static final String PRV_STR_AES128;
    private static final String PRV_STR_SAFESIGNER;
    private static final String PRV_STR_INVALIDPASS;
    private static final String PRV_STR_PASSLOCK;
    private static final String PRV_STR_WRONGCREDENTIALS;
    private static final String PRV_STR_BLOCKEDUSER;
    private static final String PRV_STR_SESSIONID;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    static {
        PRV_STR_AES128 = 'AES128';
        PRV_STR_SAFESIGNER = 'SafeSigner';
        PRV_STR_INVALIDPASS = 'Invalid Password';
        PRV_STR_PASSLOCK = 'Password Lockout';
        PRV_STR_WRONGCREDENTIALS = 'Wrong credentials';
        PRV_STR_BLOCKEDUSER = 'Blocked user';
        PRV_STR_SESSIONID = 'sessionId';
    }
    
    /**
    *  @Description: Authentication of a user
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    @HttpPost
    global static LoginResponse login() {
        LP_APIAutenticacionSelector apiSelector = new LP_APIAutenticacionSelector();
        LP_UsersSelector userSelector = new LP_UsersSelector();
        LP_LoginHistorySelector loginSelector = new LP_LoginHistorySelector();
        LoginResponse objResponse = new LoginResponse();
        RestRequest req = RestContext.request;
        try {
            LP_JSONLoginValidationRequest res = (LP_JSONLoginValidationRequest)JSON.deserialize(req.requestbody.tostring(), LP_JSONLoginValidationRequest.class);
            LP_APIAutenticacion__mdt cryptoObj = apiSelector.selectByDeveloperNameWithLimit(PRV_STR_SAFESIGNER);
            String decryptUser = decrypt(res.body.username, cryptoObj.LP_Clave__c, res.body.initializationVector);
            String decryptPass = decrypt(res.body.password, cryptoObj.LP_Clave__c, res.body.initializationVector);
            List<User> user = userSelector.selectByRutWithLimit(decryptUser);

            HttpResponse response = call(xmlGen(user, decryptUser, decryptPass), cryptoObj);
            String responseBody = response.getBody();
            String sessionId = LP_LoginValidation.getValueFromXMLString(responseBody, PRV_STR_SESSIONID);
            objResponse.statusMessage = response.getStatus();
            objResponse.statusCode = response.getStatusCode();

            if (string.isNotBlank(sessionId)) {
                objResponse.isSuccess = true;
                objResponse.sessionId = sessionId;
            } else {
                List<LoginHistory> logStatus = loginSelector.selectByUserIdWithLimit(user[0].Id);
                if (logStatus[0].Status == PRV_STR_INVALIDPASS) {
                    objResponse.statusMessage = PRV_STR_WRONGCREDENTIALS;
                    objResponse.statusCode = 400;
                } else if (logStatus[0].Status == PRV_STR_PASSLOCK) {
                    objResponse.statusMessage = PRV_STR_BLOCKEDUSER;
                    objResponse.statusCode = 402;
                }
                objResponse.isSuccess = false;
            }
        } catch (Exception ex) {
            LP_CustomException.ExceptionDetail customExp = new LP_CustomException.ExceptionDetail();
            customExp.getException(ex);
            objResponse.isSuccess = false;
            objResponse.statusMessage = ex.getMessage();
        }
        return objResponse;
    }

    /**
    *  @Description: XML generator for login consumption
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    private static String xmlGen(List<User> user, String decryptUser, String decryptPass) {
        string loginXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">';
        loginXML += '<soapenv:Header>';
        loginXML += '<urn:LoginScopeHeader>';
        loginXML += '<urn:organizationId>'+ UserInfo.getOrganizationId() +'</urn:organizationId>';
        loginXML += '</urn:LoginScopeHeader>';
        loginXML += '</soapenv:Header>';
        loginXML += '<soapenv:Body>';
        loginXML += '<urn:login>';
        if (user.size() > 0) {
            loginXML += '<urn:username>'+ user[0].Username +'</urn:username>';
        } else {
            loginXML += '<urn:username>'+ decryptUser +'</urn:username>';
        }                
        loginXML += '<urn:password>'+ decryptPass +'</urn:password>';
        loginXML += '</urn:login>';
        loginXML += '</soapenv:Body>';
        loginXML += '</soapenv:Envelope>';
        return loginXML;
    }

    /**
    *  @Description: Call to the soap service through htttp
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    private static HttpResponse call(String xml, LP_APIAutenticacion__mdt path) {
        HttpResponse response;
        HttpRequest request = new HttpRequest();
        request.setEndpoint(path.LP_URL__c);
        request.setTimeout(30000);
        request.setMethod(path.LP_Metodo__c);
        request.setHeader('SOAPAction', path.LP_Accion__c);
        request.setHeader('Content-Type', 'text/xml');
        request.setBody(xml);
        Http newHttp = new Http();
        response = newHttp.send(request);
        return response;
    }

    /**
    *  @Description: Get XML tag value from XML string
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    private static string getValueFromXMLString(string xmlString, string keyField){
        String xmlKeyValue = '';
        LoginResponse objResponse = new LoginResponse();
        if(xmlString.contains('<' + keyField + '>')){
            try{
                xmlKeyValue = xmlString.substring(xmlString.indexOf('<' + keyField + '>')+keyField.length() + 2, xmlString.indexOf('</' + keyField + '>'));   
            }catch (exception e){
                 objResponse.statusMessage = e.getMessage();
            }            
        }
        return xmlKeyValue;
    }

    /**
    *  @Description: Data encryption through the AES128 algorithm
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    public static String encrypt(String toEncrypt, String initializationVector) {
        initializationVector = EncodingUtil.base64Encode(Blob.valueOf(initializationVector));
        Blob initVector = EncodingUtil.base64Decode(initializationVector);
        LP_APIAutenticacionSelector apiSelector = new LP_APIAutenticacionSelector();
        LP_APIAutenticacion__mdt cryptoObj = apiSelector.selectByDeveloperNameWithLimit(PRV_STR_SAFESIGNER);
        Blob cryptoKey = EncodingUtil.base64Decode(cryptoObj.LP_Clave__c);
        Blob data = Blob.valueOf(toEncrypt);
        Blob encryptedData = Crypto.encrypt(PRV_STR_AES128, cryptoKey, initVector, data);
        String encryptedDataStr = EncodingUtil.base64Encode(encryptedData);
        return encryptedDataStr;
    }

    /**
    *  @Description: Data decryption through the AES128 algorithm
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    private static String decrypt(String toDecrypt, String key, String initializationVector) {
        Blob initVector = EncodingUtil.base64Decode(initializationVector);
        Blob encryptedData = EncodingUtil.base64Decode(toDecrypt);
        Blob cryptoKey = EncodingUtil.base64Decode(key);
        Blob decryptedData = Crypto.decrypt(PRV_STR_AES128, cryptoKey, initVector, encryptedData);
        return decryptedData.toString();
    }
    
    /**
    *  @Description: JSON response for post service
    *  @Autor:       ATO, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    global class LoginResponse {
        public String sessionId {get; set;}
        public Boolean isSuccess {get; set;}
        public String statusMessage {get; set;}
        public Integer statusCode {get; set;}
    }
}