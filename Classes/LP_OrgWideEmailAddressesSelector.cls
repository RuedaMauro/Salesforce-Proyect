/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 15/07/2021
Description  : Query factory for Org Wide Email Addresses using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			15/07/2021		initial version
********************************************************************************/
public with sharing class LP_OrgWideEmailAddressesSelector extends fflib_SObjectSelector {
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public Schema.SObjectType getSObjectType(){
        return OrgWideEmailAddress.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            OrgWideEmailAddress.Id,
            OrgWideEmailAddress.DisplayName, 
            OrgWideEmailAddress.Address
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the DisplayName of Org Wide Email Address as a condition
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public OrgWideEmailAddress selectByOrgWideEmailAddressDisplayNameWithLimit(String displayName){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('DisplayName = :displayName');
        query.setLimit( 1 );
        return (OrgWideEmailAddress) Database.query( query.toSOQL() );
    }
    
}