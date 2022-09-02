/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 12/07/2021
Description  : Query factory for LP_ConfiguracionDocumentos__mdt using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			12/07/2021		initial version
********************************************************************************/
public inherited sharing class LP_ConfiguracionDocumentosSelector extends fflib_SObjectSelector{
    
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    public Schema.SObjectType getSObjectType() {
        return LP_ConfiguracionDocumentos__mdt.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            LP_ConfiguracionDocumentos__mdt.DeveloperName,
            LP_ConfiguracionDocumentos__mdt.Id,
            LP_ConfiguracionDocumentos__mdt.Label,
            LP_ConfiguracionDocumentos__mdt.Language,
            LP_ConfiguracionDocumentos__mdt.LP_CodigoDeDocumento__c,
            LP_ConfiguracionDocumentos__mdt.LP_CorreoInstitucion__c,
            LP_ConfiguracionDocumentos__mdt.LP_Formato__c,
            LP_ConfiguracionDocumentos__mdt.LP_Id__c,
            LP_ConfiguracionDocumentos__mdt.LP_Institucion__c,
            LP_ConfiguracionDocumentos__mdt.LP_Orden__c,
            LP_ConfiguracionDocumentos__mdt.LP_RolDelFirmante__c,
            LP_ConfiguracionDocumentos__mdt.LP_RUTInstitucion__c,
            LP_ConfiguracionDocumentos__mdt.LP_TipoDefirmante__c,
            LP_ConfiguracionDocumentos__mdt.LP_TipoDeTarjeta__c,
            LP_ConfiguracionDocumentos__mdt.MasterLabel,
            LP_ConfiguracionDocumentos__mdt.NamespacePrefix,
            LP_ConfiguracionDocumentos__mdt.QualifiedApiName
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the Credit Card Type as a condition
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    public List<LP_ConfiguracionDocumentos__mdt> selectByCreditCardTypeWithLimit(String creditCardType, List<String> ids) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_TipoDeTarjeta__c = :creditCardType AND LP_Id__c IN :ids');
        return (List<LP_ConfiguracionDocumentos__mdt>) Database.query( query.toSOQL() );
    }
}