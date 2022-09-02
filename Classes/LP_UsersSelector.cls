/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 09/08/2021
Description  : Query factory for User using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			09/08/2021		initial version
********************************************************************************/
public inherited sharing class LP_UsersSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public Schema.SObjectType getSObjectType() {
        return User.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            User.Blocked_Time__c,
            User.firstname,
            User.Id,
            User.Is_Blocked__c,
            User.LastLoginDate,
            User.RUT__c,
            User.Username
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the rut as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public List<User> selectByRutWithLimit(String rut) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('RUT__c = :rut');
        query.setLimit( 1 );
        return (List<User>) Database.query( query.toSOQL() );
    }
    
    /**
    *  @Description: Perform a query with the default fields with the Id as a condition
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<User> selectByIdWithLimit(String Id) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Id = :Id');
        query.setLimit( 1 );
        return (List<User>) Database.query( query.toSOQL() );
    }
}