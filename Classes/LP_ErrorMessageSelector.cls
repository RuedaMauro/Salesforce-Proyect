/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 20/09/2021
Description  : Query factory for LoginHistory using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damián Alejandro Biaggio	DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			20/09/2021		initial version
********************************************************************************/
public inherited sharing class LP_ErrorMessageSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/09/2021
    */
    public Schema.SObjectType getSObjectType() {
        return LP_Mensaje_Sitio_Privado__mdt.sObjectType;
    }    

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/09/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            LP_Mensaje_Sitio_Privado__mdt.LP_Mensaje__c,
            LP_Mensaje_Sitio_Privado__mdt.label         
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the User Id as a condition
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        20/09/2021
    */
    public List<LP_Mensaje_Sitio_Privado__mdt> selectByLabel(String label) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('label = :label');
        return (List<LP_Mensaje_Sitio_Privado__mdt>) Database.query( query.toSOQL() );
    }
}