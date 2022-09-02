/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_LeadsSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            16/06/2021	   	    Created Class
********************************************************************************/
@isTest
public with sharing class LP_LeadsSelector_TEST {

    private static LP_LeadsSelector leadSelector;

    @testSetup 
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        Lead lead = LP_DataFactory.createLeadWithRUT(true, nac);
	}

    /**
    *  @Description: Test the selectByRutWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByRutWithLimitTest() {
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead lead = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        System.assertEquals(lead != Null, true, 'The Lead record has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test the selectByRutWithLeadCountry method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByRutWithLeadCountryTest() {
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Lead lead = leadSelector.selectByRutWithLeadCountry(LP_DataFactory.PRV_PARAM_RUT_LEAD);
        System.assertEquals(lead != Null, true, 'The Lead record has been returned');
        Test.stopTest();
    }

    /**
    *  @Description: Test the selectByLeadIdWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByLeadIdWithLimitTest() {
        Test.startTest();
        leadSelector = new LP_LeadsSelector();
        Id leadId = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD).Id;
        Lead lead = leadSelector.selectByLeadIdWithLimit(leadId);
        System.assertEquals(lead != Null, true, 'The Lead record has been returned');
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
        leadSelector = new LP_LeadsSelector();
        Id leadId = leadSelector.selectByRutWithLimit(LP_DataFactory.PRV_PARAM_RUT_LEAD).Id;
        List<Lead> lead = leadSelector.selectById(new Set<Id>{leadId});
        System.assertEquals(lead.size() > 0, true, 'The Lead record has been returned');
        Test.stopTest();
    }
}
