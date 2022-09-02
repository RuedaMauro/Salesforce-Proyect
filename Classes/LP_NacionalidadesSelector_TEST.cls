/*********************************************************************************
Project      : La Polar Salesforce Service Cloud
Created By   : Deloitte
Created Date : 16/06/2021
Description  : Test Class LP_NacionalidadesSelector
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos O			    ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            	Description
1.0      ATO            16/06/2021	   	    Created Class
********************************************************************************/
@isTest
public without sharing class LP_NacionalidadesSelector_TEST {

    private static LP_NacionalidadesSelector countrySelector;

    /**
    *  @Description: Test the selectByIdWithLimit method
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        16/06/2021
    */
    @isTest 
    static void selectByIdWithLimit() {
        Test.startTest();
        countrySelector = new LP_NacionalidadesSelector();
        LP_Nacionalidad__c cnt = LP_DataFactory.createNationalityCL(true);
        cnt = countrySelector.selectByIdWithLimit(cnt.Id);
        System.assertEquals(cnt != null, true, 'The Lead record has been returned');
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
        countrySelector = new LP_NacionalidadesSelector();
        LP_Nacionalidad__c cnt = LP_DataFactory.createNationalityCL(true);
        List<LP_Nacionalidad__c> cntList = countrySelector.selectById(new Set<Id>{cnt.Id});
        System.assertEquals(cntList.size() > 0, true, 'The Lead record has been returned');
        Test.stopTest();
    }
}
