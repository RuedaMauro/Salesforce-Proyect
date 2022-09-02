/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_BasesExpressSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            16/06/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_BasesExpressSelector_TEST {

    private static LP_BasesExpressSelector xpressSelector;

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createLeadBaseExpressWithRUT(true, nac);
	}

    /**
    *  @Description: Test the selectByRutWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByRutWithLimitTest() {
        Test.startTest();
        xpressSelector = new LP_BasesExpressSelector();
        LP_Base_Express__c xpress = xpressSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        System.assertEquals(xpress != Null, true, 'The Base Express record has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test the selectById method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByIdTest() {
        Test.startTest();
        xpressSelector = new LP_BasesExpressSelector();
        Id xpressId = xpressSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD).Id;
        List<LP_Base_Express__c> xpress = xpressSelector.selectById(new Set<Id>{xpressId});
        System.assertEquals(xpress.size() > 0, true, 'The  Base Express record has been returned');
        Test.stopTest();
    }
}
