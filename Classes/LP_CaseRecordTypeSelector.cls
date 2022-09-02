/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 31/08/2021
Description  : Query factory for Cases Record Types using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Gustavo Leon Paredes		GLP
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      GLP			31/08/2021		initial version
********************************************************************************/

public with sharing class LP_CaseRecordTypeSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */
    public Schema.SObjectType getSObjectType(){
        return RecordType.getSObjectType();
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            RecordType.Id,
            RecordType.Name
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the sObjectType Case as a condition
    *  @Autor:       Gustavo Leon, Deloitte, gleonp@deloitte.com
    *  @Date:        31/08/2021
    */

    public map<String, RecordType> selectAllRecordCaseTypes(){
        fflib_QueryFactory query = newQueryFactory();
        String whereClause = 'SObjectType = \'Case\'';
        query.setCondition(whereClause);

        map<String, RecordType> recordtypeMap = new map<String, RecordType>();
        for(RecordType item : (list<RecordType>) Database.query( query.toSOQL() )){
            recordtypeMap.put(item.Id, item);
        }
        return recordtypeMap;
    }
    
}