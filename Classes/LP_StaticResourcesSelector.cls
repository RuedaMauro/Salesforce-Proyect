/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 15/07/2021
Description  : Query factory for StaticResorces using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			15/07/2021		initial version
********************************************************************************/
public without sharing class LP_StaticResourcesSelector extends fflib_SObjectSelector{
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public Schema.SObjectType getSObjectType(){
        return StaticResource.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            StaticResource.Name, 
            StaticResource.NamespacePrefix, 
            StaticResource.SystemModStamp
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the Name of StaticResources as a condition
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public StaticResource selectByStaticResourceNameWithLimit(String name){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Name = :name');
        query.setLimit( 1 );
        return (StaticResource) Database.query( query.toSOQL() );
    }
}