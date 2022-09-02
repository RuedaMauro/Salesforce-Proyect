/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 26/04/2021
Description  : Test LP_Utility
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos                 ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO		    26/04/2021		Created the class
********************************************************************************/
@isTest
public with sharing class LP_Utility_TEST {
    
    /**
    * @description Testing of all methods
    * @Autor       ATO, Deloitte, atejoso@deloitte.com
    * @date        26/04/2021
    */
    @isTest static void allMethodsTest() {
        String objOnBrd = Schema.SObjectType.LP_OnBoarding__c.getName();
        String fieldPath = Schema.SObjectType.LP_OnBoarding__c.fields.LP_Ruta__c.getName();
        Test.startTest();
        List<LP_Utility.PathWrapper> pathList = LP_Utility.getPickListValuesIntoPath(objOnBrd, fieldPath);
        pathList.sort();
        System.assertEquals(pathList.size() > 0, true, 'The data of path has been returned');
        Test.stopTest();
    }

    /**
    * @Description: Test Method to LP_Utility getDescribedObjects method
    * @Autor        ATO, Deloitte, atejoso@deloitte.com
    * @date         26/04/2021
    */    
    @isTest static void getDescribedObjectsTests(){
        Test.startTest();
        String objDsc = LP_Utility.getDescribedObjects( new List<String>{'Account'} );
        System.assertEquals(objDsc.contains('Account'), true, 'The JSON has been returned');
        Test.stopTest();
    }
}