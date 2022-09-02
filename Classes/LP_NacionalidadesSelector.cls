/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 01/06/2021
Description  : Query factory for Nacionalidad using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			01/06/2021		initial version
********************************************************************************/
public without sharing class LP_NacionalidadesSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Schema.SObjectType getSObjectType(){
        return LP_Nacionalidad__c.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            LP_Nacionalidad__c.CreatedDate,
            LP_Nacionalidad__c.Id,
            LP_Nacionalidad__c.LP_Activo__c ,
            LP_Nacionalidad__c.LP_CodigoNacionalidad__c,
            LP_Nacionalidad__c.LP_Pais__c,
            LP_Nacionalidad__c.Name
        };
    }

    /**
    *  @Description: Perform a query with the default fields with set of Ids as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<LP_Nacionalidad__c> selectById(Set<Id> recordIds){
        return (List<LP_Nacionalidad__c>) selectSObjectsById(recordIds);
    }

    /**
    *  @Description: Perform a query with the default fields with the Id as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Nacionalidad__c selectByIdWithLimit(Id objId){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Id = :objId');
        query.setLimit( 1 );
        return (LP_Nacionalidad__c) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the Code as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Nacionalidad__c selectByCodeWithLimit(String code){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_CodigoNacionalidad__c  = :code');
        query.setLimit( 1 );
        return (LP_Nacionalidad__c) Database.query( query.toSOQL() );
    }
}