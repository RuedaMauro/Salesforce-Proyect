/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 01/06/2021
Description  : Query factory for express base using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			01/06/2021		initial version
********************************************************************************/
public without sharing class LP_BasesExpressSelector extends fflib_SObjectSelector{
    
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Schema.SObjectType getSObjectType(){
        return LP_Base_Express__c.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            LP_Base_Express__c.CreatedDate,
            LP_Base_Express__c.CurrencyIsoCode,
            LP_Base_Express__c.Id,
            LP_Base_Express__c.LP_Cupo__c,
            LP_Base_Express__c.LP_DV__c,
            LP_Base_Express__c.LP_OfertaTarjeta__c,
            LP_Base_Express__c.LP_Rut__c,
            LP_Base_Express__c.LP_TipoCliente__c,
            LP_Base_Express__c.Name
        };
    }

    /**
    *  @Description: Perform a query with the default fields with set of Ids as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<LP_Base_Express__c> selectById(Set<Id> recordIds){
        return (List<LP_Base_Express__c>) selectSObjectsById(recordIds);
    }

    /**
    *  @Description: Perform a query with the default fields with the RUT as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Base_Express__c selectByRutWithLimit(String rut){
        rut = rut.split('-')[0];
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_Rut__c = :rut');
        query.setLimit( 1 );
        return (LP_Base_Express__c) Database.query( query.toSOQL() );
    }
}