/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 09/08/2021
Description  : Query factory for LoginHistory using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			09/08/2021		initial version
********************************************************************************/
public inherited sharing class LP_LoginHistorySelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public Schema.SObjectType getSObjectType() {
        return LoginHistory.sObjectType;
    }

    /**
    *  @Description: Overwrite the order of the query - fix the bug in the fflib library
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        07/09/2021
    */
    public override String getOrderBy() {
        return 'LoginTime DESC';
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            LoginHistory.Id,
            LoginHistory.LoginTime,
            LoginHistory.Status,
            LoginHistory.UserId            
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the User Id as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/08/2021
    */
    public List<LoginHistory> selectByUserIdWithLimit(Id uId) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('UserId = :uId AND LoginTime = TODAY');
        query.addOrdering('LoginTime', fflib_QueryFactory.SortOrder.ASCENDING);
        return (List<LoginHistory>) Database.query( query.toSOQL() );
    }
    
     /**
    *  @Description: Perform a query with the default fields with the User Id as a condition
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<LoginHistory> selectByUserIdWithLimit2(Id uId) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('UserId = :uId');
        query.addOrdering('LoginTime', fflib_QueryFactory.SortOrder.DESCENDING);
        query.setLimit( 2 );
        return (List<LoginHistory>) Database.query( query.toSOQL() );
    }
}