/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 01/06/2021
Description  : Query factory for Lead using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			01/06/2021		initial version
********************************************************************************/
public without sharing class LP_LeadsSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Schema.SObjectType getSObjectType(){
        return Lead.sObjectType;
    }
    
    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            Lead.Address,
            Lead.City,
            Lead.Company,
            Lead.ConvertedAccountId,
            Lead.ConvertedContactId,
            Lead.ConvertedDate,
            Lead.ConvertedOpportunityId,
            Lead.Country,
            Lead.CreatedDate,
            Lead.CurrencyIsoCode,
            Lead.Email,
            Lead.FirstName,
            Lead.Id,
            Lead.IsConverted,
            Lead.LastName,
            Lead.LeadSource,
            Lead.LP_AceptacionContratos__c,
            Lead.LP_ApellidoMaterno__c,
            Lead.LP_CupoDisponible__c,
            Lead.LP_EstadoCuentaMail__c,
            Lead.LP_FechaPago__c,
            Lead.LP_Genero__c,
            Lead.LP_Nacionalidad__c,
            Lead.LP_Ciudad__c,
            Lead.LP_NivelEducacional__c,
            Lead.LP_NumeroCelularValidado__c,
            Lead.LP_Ocupacion__c,
            Lead.LP_Rut__c,
            Lead.LP_TipoTarjeta__c,
            Lead.MasterRecordId,
            Lead.MobilePhone,
            Lead.Name,
            Lead.Phone,
            Lead.PhotoUrl,
            Lead.Rating,
            Lead.Salutation,
            Lead.State,
            Lead.Status,
            Lead.Street,
            Lead.Title,
            Lead.Website,
            Lead.LP_GentilicioNacionalidad__c,
            Lead.LP_NombreCiudad__c,
            Lead.LP_NumDeptoCasa__c
        };
    }

    /**
    *  @Description: Perform a query with the default fields with set of Ids as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Lead> selectById(Set<Id> recordIds){
        return (List<Lead>) selectSObjectsById(recordIds);
    }

    /**
    *  @Description: Perform a query with the default fields with the Id of Lead as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Lead selectByLeadIdWithLimit(Id leadId){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Id = :leadId');
        query.setLimit( 1 );
        return (Lead) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the RUT of Lead as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Lead selectByRutWithLimit(String rut){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_Rut__c = :rut');
        query.setLimit( 1 );
        return (Lead) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the rut as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Lead> selectByRutInAList(String rut) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_Rut__c = :rut');
        query.setLimit( 1 );
        return (List<Lead>) Database.query( query.toSOQL() );
    }
    
    /**
    *  @Description: Performs a query with fields defined in the method with the RUT of Lead as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Lead selectByRutWithLeadCountry(String rut){
        return (Lead) Database.query(
        newQueryFactory(false)
        .selectField(Lead.Id)
        .selectField(Lead.Name)
        .selectField(Lead.Email)
        .selectField(Lead.LP_Rut__c)
        .selectField('LP_Nacionalidad__r.LP_CodigoNacionalidad__c')
        .selectField('LP_Nacionalidad__r.LP_Pais__c')
        .setCondition('LP_Rut__c = :rut')
        .setLimit( 1 )
        .toSOQL()
        );
    }
}