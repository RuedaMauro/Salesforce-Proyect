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
public with sharing class LP_DocumentController {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String MSG_ERROR;
    private static final String MSG_CONGRATS;
    private static final String MSG_DOC_NOT_FOUND;
    
    
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
        MSG_DOC_NOT_FOUND = 'Documento no encontrado';
    }
    
    /**
*  @Description: Get refinanciation Data from client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        02/08/2021  
*/
    @AuraEnabled
    public static LP_Response getDocumentList(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId()); //[SELECT Id,Rut__c FROM User WHERE Id =:UserInfo.getUserId()];
        String rutdv = users[0].Rut__c;
        List<String> split = LP_DocumentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 151 data
        try{
            rp = LP_GetDocList.getDocList(String.valueOf(rp.rut));
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
*  @Description: Get refinanciation Data from client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        02/08/2021  
*/
    @AuraEnabled
    public static String getDocumentLink(String code){
        //API 103 data
        try{
            return(LP_Get103Data.get103Data(code));
        }
        catch(Exception e){
            return MSG_DOC_NOT_FOUND;
        }
    }
    
    /**
*  @Description: Get refinanciation Data from client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        02/08/2021  
*/
    @AuraEnabled
    public static LP_Response LP_getDataClient(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId()); 
        String rutdv = users[0].Rut__c;
        List<String> split = LP_DocumentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 1422 data
        try{
            rp = LP_DemographicCall.demographicClientCall(rp);
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, MSG_ERROR, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        rp.message = MSG_CONGRATS;
        rp.loginOK = true;
        return rp;
    }
	
    /**
*  @Description: Get refinanciation Data from client.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        02/08/2021  
*/
    @AuraEnabled
    public static LP_Response LP_getDemographicDataClient(){
        LP_Response rp = new LP_Response();
        LP_UsersSelector u= new LP_UsersSelector();
        List<User> users = u.selectByIdWithLimit(UserInfo.getUserId()); 
        String rutdv = users[0].Rut__c;
        List<String> split = LP_DocumentController.getRutDv(rutdv);
        rp.rut = Integer.valueOf(split[0]);
        rp.dv = split[1];
        //API 1422 data
        try{
            rp = LP_DemographicClientCall.demographicClientCallEmail(rp);
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, MSG_ERROR, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        rp.message = MSG_CONGRATS;
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
    
}