/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 31/08/2021
Description  : Query factory for Business Hours using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Gustavo Leon Paredes		GLP
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      GLP			31/08/2021		initial version
********************************************************************************/

public with sharing class LP_BusinessHoursSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */
    public Schema.SObjectType getSObjectType(){
        return BusinessHours.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            BusinessHours.Id
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the IsDefault true as a condition
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */

    public BusinessHours selectActiveBusinessHours(){
        fflib_QueryFactory query = newQueryFactory();
        String whereClause = 'IsDefault=true';
        query.setCondition(whereClause);

        return (BusinessHours) Database.query( query.toSOQL() );
    }
    
}