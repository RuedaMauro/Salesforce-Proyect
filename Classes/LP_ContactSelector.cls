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
public without sharing class  LP_ContactSelector extends fflib_SObjectSelector{
     
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public Schema.SObjectType getSObjectType() {
        return Contact.sObjectType;
    }
    
     /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Contact.id,
            Contact.name
        };
    }
    
    /**
    *  @Description: Perform a query with the default fields with the AccountId as a condition
    *  @Autor:       Germán Basgall, Deloitte, gbasgall@deloitte.com
    *  @Date:        12/08/2021
    */
    public List<Contact> selectByAccountIdWithLimit(String accId) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('AccountId = :accId');
        query.setLimit( 1 );
        return (List<Contact>) Database.query( query.toSOQL() );
    }

}