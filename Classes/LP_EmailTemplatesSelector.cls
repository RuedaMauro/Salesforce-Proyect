/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 15/07/2021
Description  : Query factory for Email Templates using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			15/07/2021		initial version
********************************************************************************/
public without sharing class LP_EmailTemplatesSelector extends fflib_SObjectSelector{
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public Schema.SObjectType getSObjectType(){
        return EmailTemplate.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            EmailTemplate.Id,
            EmailTemplate.Body,
            EmailTemplate.HtmlValue,
            EmailTemplate.Subject
        };
    }
    
    /**
    *  @Description: Perform a query with the default fields with the DeveloperName of Email Templates as a condition
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        15/07/2021
    */
    public EmailTemplate selectByEmailTemplateDeveloperNameWithLimit(String developerName){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('DeveloperName = :developerName');
        query.setLimit( 1 );
        return (EmailTemplate) Database.query( query.toSOQL() );
    }    
}