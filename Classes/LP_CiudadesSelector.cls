/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 15/08/2021
Description  : Query factory for Ciudad using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			15/08/2021		initial version
********************************************************************************/
public inherited sharing class LP_CiudadesSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        15/08/2021
    */
    public Schema.SObjectType getSObjectType(){
        return LP_Ciudad__c.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        15/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            LP_Ciudad__c.CreatedDate,
            LP_Ciudad__c.Id,
            LP_Ciudad__c.Name
        };
    }

    /**
    *  @Description: Perform a query with the default fields with set of Ids as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        15/08/2021
    */
    public List<LP_Ciudad__c> selectById(Set<Id> recordIds){
        return (List<LP_Ciudad__c>) selectSObjectsById(recordIds);
    }

    /**
    *  @Description: Perform a query with the default fields with the Id as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        15/08/2021
    */
    public LP_Ciudad__c selectByIdWithLimit(Id objId){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Id = :objId');
        query.setLimit( 1 );
        return (LP_Ciudad__c) Database.query( query.toSOQL() );
    }
}