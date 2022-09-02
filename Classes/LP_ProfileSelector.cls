/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 12/08/2021
Description  : Query factory for Profile using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Germán Luis Basgall			GLB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      GLB			12/08/2021		initial version
********************************************************************************/
public  class LP_ProfileSelector extends fflib_SObjectSelector{
    
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public Schema.SObjectType getSObjectType() {
        return Profile.sObjectType;
    }
    
    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Profile.Id,
            Profile.Name
        };
    }
    
     /**
    *  @Description: Perform a query with the default fields with the name as a condition
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<Profile> selectByNameWithLimit(String name) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Name = :name');
        query.setLimit( 1 );
        return (List<Profile>) Database.query( query.toSOQL() );
    }

}