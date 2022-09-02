/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 28/05/2021
Description  : Custom Exception Class
History      : PCRM-279
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade             EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA		    28/05/2021		Created the class
********************************************************************************/
public with sharing class LP_CustomException extends Exception {

    /*
    *  @Description: Initialization of static variables Type-Error and Map Onboarding
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunoz@deloitte.com
    *  @Date:        17/05/2021
    */
    public static final String PRV_ERR_EXIST_CLIENT;
    public static final String PRV_ERR_NOCARD;
    public static final String PRV_ERR_SYSTEM;
    
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        PRV_ERR_EXIST_CLIENT = Label.LP_ERR_EXIST_CLIENT;
        PRV_ERR_NOCARD = Label.LP_ERR_NOCARD;
        PRV_ERR_SYSTEM = Label.LP_ERR_SYSTEM;
    }

    /**
    *  @Description: Exception Detail Class
    *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
    *  @Date:        31/05/2021
    */
    public class ExceptionDetail {
        public String message;
        public String cause;
        public Boolean internalError;
        
        /**
        *  @Description: Detail Exception
        *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
        *  @Date:        31/05/2021
        */
        public ExceptionDetail(Exception e, String cause, Boolean internalError) {            
            this.message = e != null ? getException(e) : null;
            this.cause = cause;
            this.internalError = internalError;
        }

        public ExceptionDetail() {}

        /**
        *  @Description: Get Exception detail
        *  @Autor:       EAA, Deloitte, eandradea@deloitte.com
        *  @Date:        31/05/2021
        */
        public String getException(Exception e) {
            String message = 'Stack trace: ' + e.getStackTraceString() + ' Message: ' + e.getMessage() + ' Type: ' + e.getTypeName() + ' Orginal Cause: ' + e.getCause() + ' Line Number: ' + e.getLineNumber();
            System.debug('Exception: { ' + message + ' }');
            return message;
        }
    }

}