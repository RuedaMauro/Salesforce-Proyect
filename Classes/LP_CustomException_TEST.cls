/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 28/05/2021
Description  : Test for Custom Exception Class
History      : PCRM-279
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade             EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA		    28/05/2021		Created the class
********************************************************************************/
@isTest
public with sharing class LP_CustomException_TEST {

    @isTest static void exceptionInternalErrorTest() {

        String cad = null;
        Test.startTest();
        try{
            cad = cad.toUpperCase();
        }catch(Exception e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, '', true);
            System.debug('detail: '+ed);
            LP_CustomException er = new LP_CustomException(JSON.serialize(ed));
            System.debug('exception: '+er);
            system.assertNotEquals(ed, null, 'Error returned');
        }
        Test.stopTest();
    }

    @isTest static void exceptionNotInternalErrorTest() {

        String cad = null;
        Test.startTest();

            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_EXIST_CLIENT, false);
            System.debug('detail: '+ed);
            LP_CustomException er = new LP_CustomException(JSON.serialize(ed));
            System.debug('exception: '+er);
            system.assertNotEquals(ed, null, 'Error returned');
        
        Test.stopTest();
    }

}