/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_AccountsSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            16/06/2021	   	    Created Class
********************************************************************************/
@isTest
public without sharing class LP_AccountsSelector_TEST {

    private static LP_AccountsSelector accSelector;
    
    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createAccountAndLeadWithRUT(true, nac);
    }

    /**
    *  @Description: Test the selectByRutWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByRutWithLimitTest() {
        Test.startTest();
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        System.assertEquals(acc != Null, true, 'the account record has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test the selectPersonAccountByRut method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectPersonAccountByRutTest() {
        Test.startTest();
        accSelector = new LP_AccountsSelector();
        Account acc = accSelector.selectPersonAccountByRut(LP_DataFactory.PRV_PARAM_RUT_LEAD_ACCOUNT);
        System.assertEquals(acc != Null, true, 'the account record has been returned');
        Test.stopTest();
    }
}
