/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 08/04/2021
Description  : Class responsible to the Rest Connection
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            08/04/2021		   	Created Class
********************************************************************************/
public with sharing class LP_RestConnectionWithAuth extends LP_RestConnectionUtility{   

    private LP_ServicioIntegracion__mdt service {set; get;}
    private LP_RutaIntegracion__mdt path {set; get;}
    private String token {get; set;}

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    private static final String PVR_STR_HEADER;
    private static final String PVR_STR_QUERY;
    private static final String PVR_STR_PATH;
    private static final String PVR_STR_AUTH;
    private static final String PVR_PATH_TOKEN;
    private static final String PVR_SRV_BASEURL;
    private static final String PVR_ORG_CACHEPARTITION;
    private static final String PVR_ORG_AUTHTOKEN;
    private static final String PVR_ORG_TOKENVALIDUNTIL;
    private static final String PVR_BDY_GRANTTYPE;
    private static final String PVR_ORG_AUTHTOKEN_PRIVATE_SITE;
    private static final String PVR_ORG_TOKENVALIDUNTIL_PRIVATE_SITE;
    private static final String PVR_PATH_TOKEN_PRIVATE_SITE;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        PVR_STR_HEADER = 'header';
        PVR_STR_QUERY = 'query';
        PVR_STR_PATH = 'path';
        PVR_STR_AUTH = 'Authorization';
        PVR_PATH_TOKEN = 'AutenticacionAPIGEE';
        PVR_SRV_BASEURL = 'URL_Base_Integracion';
        PVR_ORG_CACHEPARTITION = 'local.LPAutenticacionCache'; 
        PVR_ORG_AUTHTOKEN = 'AuthorizationToken';
        PVR_ORG_TOKENVALIDUNTIL ='TokenValidUntil';        
        PVR_BDY_GRANTTYPE = 'grant_type=client_credentials';
        PVR_ORG_AUTHTOKEN_PRIVATE_SITE = 'AuthorizationTokenPrivateSite';
        PVR_ORG_TOKENVALIDUNTIL_PRIVATE_SITE ='TokenValidUntilPrivateSite';
        PVR_PATH_TOKEN_PRIVATE_SITE = 'AutenticacionAPIGEE_Sitio_Privado';
    }

    /**
    *  @Description: Constructor to initialize the class
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    public LP_RestConnectionWithAuth(String nameService, String namePath) {
        this.service = PVR_MAP_SERVICE.get(nameService);        
        this.path = PVR_MAP_PATH.get(namePath);
    }

    /**
    *  @Description: Call service, centralization of rest calls
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    public HttpResponse callService(Map <String, Map<String,String>> connSetting, String body) {

        String endpoint = path.DeveloperName == PVR_PATH_TOKEN || path.DeveloperName == PVR_PATH_TOKEN_PRIVATE_SITE ? path.LP_RutaURL__c : service.LP_URLBase__c + path.LP_RutaURL__c;
        HttpRequest request = new HttpRequest();
        if (connSetting.containsKey(PVR_STR_PATH)) {
            for (String param : connSetting.get(PVR_STR_PATH).keyset()) {
                endpoint = endpoint + '/' + connSetting.get(PVR_STR_PATH).get(param);
            }
        }

        if (connSetting.containsKey(PVR_STR_QUERY)) {
            Integer i = 0;
            endpoint += !connSetting.get(PVR_STR_QUERY).isEmpty() ? '?' : '';
            for (String param : connSetting.get(PVR_STR_QUERY).keyset()) {
                endpoint += param + '=' + connSetting.get(PVR_STR_QUERY).get(param);
                endpoint += ++i == connSetting.get(PVR_STR_QUERY).size() ? '' : '&';
            }
        }

        if (connSetting.containsKey(PVR_STR_HEADER)) {
            if (path.DeveloperName != PVR_PATH_TOKEN || path.DeveloperName != PVR_PATH_TOKEN_PRIVATE_SITE) {
                connSetting.get(PVR_STR_HEADER).put(PVR_STR_AUTH, '');
            }            
            connSetting.get(PVR_STR_HEADER).putAll(fillMapHeader(path.LP_Cabeceras__c));
            for (String param : connSetting.get(PVR_STR_HEADER).keySet()) {
                if (param == PVR_STR_AUTH && path.DeveloperName != PVR_PATH_TOKEN && path.DeveloperName != PVR_PATH_TOKEN_PRIVATE_SITE && service.DeveloperName == PVR_SRV_BASEURL) {
                    request.setHeader(param, 'Bearer ' + token);
                } else {
                    request.setHeader(param, connSetting.get(PVR_STR_HEADER).get(param));
                }
            }
        }
        system.debug('endpoint: ' + endpoint);
        request.setEndpoint(endpoint);
        request.setMethod(path.LP_Metodo__c);
        request.setTimeout(120000);
        if (String.isNotBlank(body)) {
            request.setBody(body);
            system.debug('body: ' + body);
        }

        HttpResponse response;
        
        try {
            response = new Http().send(request);
            system.debug('response: ' + response.getBody());
            if (response.getStatusCode() != 200 && response.getStatusCode() != 201) {
                createErrorService(response.getStatus(), response.getStatusCode());
            }
        } catch (CalloutException ex) {
            throw new ServiceException(ex.getMessage(), ex);
        } catch (JSONException ex) {
            throw new ServiceException(ex.getMessage());
        }
        return response;
    }

    /**
    *  @Description: Call to services with authorization token
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */
    public HttpResponse callServiceWithToken(Map <String, Map<String,String>> connSetting, String body) {
        HttpResponse response;
        // Get the partition where the token will be stored
        Cache.OrgPartition orgPart = Cache.Org.getPartition(PVR_ORG_CACHEPARTITION);
        // Get the cached token
        String cachedToken = (String)orgPart.get(PVR_ORG_AUTHTOKEN);
        // Get get the time that was cached
        DateTime cachedValid = (DateTime)orgPart.get(PVR_ORG_TOKENVALIDUNTIL);
        // Check if the token duration time is valid
        Boolean isValidToken = isValidToken(cachedValid);
        system.debug('isValidToken: ' + isValidToken);
        system.debug('cachedToken: ' + cachedToken);
        // If the token is not valid get a new token
        if (cachedToken == null || !isValidToken) {
            LP_RutaIntegracion__mdt auxPath = this.path;
            system.debug('auxPath: ' + auxPath);
            this.path = PVR_MAP_PATH.get(PVR_PATH_TOKEN);
            system.debug('path: ' + path);
            // Call the api to get the token and cache it
            orgPart.put(PVR_ORG_AUTHTOKEN, getToken());
            orgPart.put(PVR_ORG_TOKENVALIDUNTIL, dateTime.now());
            token = (String)orgPart.get(PVR_ORG_AUTHTOKEN);
            this.path = auxPath;
            response = callService(connSetting, body);

        } else if (cachedToken != null && isValidToken) {
            token = cachedToken;
            response = callService(connSetting, body);
        }
        return response;
    }
    
    /**
    *  @Description: Call to services with authorization token
    *  @Autor:       Biaggio, Damian dbiaggio@deloitte.com
    *  @Date:        02/07/2021
    */
    public HttpResponse callServiceWithTokenPrivateSite(Map <String, Map<String,String>> connSetting, String body) {
        HttpResponse response;
        // Get the partition where the token will be stored
        Cache.OrgPartition orgPart = Cache.Org.getPartition(PVR_ORG_CACHEPARTITION);
        // Get the cached token
        String cachedToken = (String)orgPart.get(PVR_ORG_AUTHTOKEN_PRIVATE_SITE);
        // Get get the time that was cached
        DateTime cachedValid = (DateTime)orgPart.get(PVR_ORG_TOKENVALIDUNTIL_PRIVATE_SITE);
        // Check if the token duration time is valid
        Boolean isValidToken = isValidToken(cachedValid);
        system.debug('isValidToken: ' + isValidToken);
        system.debug('cachedToken: ' + cachedToken);
        // If the token is not valid get a new token
        if (cachedToken == null || !isValidToken) {
            LP_RutaIntegracion__mdt auxPath = this.path;
            system.debug('auxPath: ' + auxPath);
            this.path = PVR_MAP_PATH.get(PVR_PATH_TOKEN_PRIVATE_SITE);
            system.debug('path: ' + path);
            // Call the api to get the token and cache it
            orgPart.put(PVR_ORG_AUTHTOKEN_PRIVATE_SITE, getToken());
            orgPart.put(PVR_ORG_TOKENVALIDUNTIL_PRIVATE_SITE, dateTime.now());
            token = (String)orgPart.get(PVR_ORG_AUTHTOKEN_PRIVATE_SITE);
            this.path = auxPath;
            response = callService(connSetting, body);

        } else if (cachedToken != null && isValidToken) {
            token = cachedToken;
            response = callService(connSetting, body);
        }
        return response;
    }

    /**
    *  @Description: Get token, get the Token for the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    public String getToken() {
        String accessTokenValue;
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put(PVR_STR_HEADER, mapHeader);
        setConf.put(PVR_STR_PATH, pathParam);
        String body = callService(setConf, PVR_BDY_GRANTTYPE).getBody();
        system.debug('LP TOKEN: ' + body);
        LP_JSONTokenResponse lpToken = LP_JSONTokenResponse.parse(body);
        accessTokenValue = lpToken.access_token;
        return accessTokenValue;
    }

    /**
    *  @Description: Create error service, used to create and throw a service error
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    private void createErrorService (String message, integer code){
        switch on code {
            when  400 {
                throw new ServiceException(message, code);
            }
            when  401 {
                throw new ServiceException(message, code);
            }
            when  404 {
                throw new ServiceException(message, code);
            }
            when  500 {
                throw new ServiceException(message, code);
            }
            when else {
                throw new ServiceException(message, code);
            }
        }
    }

    /**
    *  @Description: Service exception, wrapper class used to set a service exception
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        08/04/2021
    */    
    public class ServiceException extends Exception {
        public Integer code;
        public ServiceException(String message, Integer code)
        {
            this(message);
            this.code = code;            
        }
    }
}