/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 01/06/2021
Description  : Query factory for Account using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			01/06/2021		initial version
********************************************************************************/
public without sharing class LP_AccountsSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Account.CurrencyIsoCode,
            Account.FirstName,
            Account.Id,
            Account.IsPersonAccount,
            Account.LastName,
            Account.LP_AceptacionContratos__pc,
            Account.LP_ApellidoMaterno__pc,
            Account.LP_Ciudad__pc,
            Account.LP_CuentaCreadaSitios__pc,
            Account.LP_CupoDisponible__pc,
            Account.LP_CreacionClaveInternet__pc,
            Account.LP_CreadoOnboarding__pc,
            Account.LP_EstadoCuentaMail__pc,
            Account.LP_FechaPago__pc,
            Account.LP_Genero__pc,
            Account.LP_Nacionalidad__pc,
            Account.LP_NumDeptoCasa__pc,
            Account.LP_Ocupacion__pc,
            Account.LP_Rut__c,
            Account.LP_TipoTarjeta__pc,
            Account.OwnerId,
            Account.PersonBirthdate,
            Account.PersonContactId,
            Account.PersonDepartment,
            Account.PersonDoNotCall,
            Account.PersonEmail,
            Account.PersonHasOptedOutOfEmail,
            Account.PersonHasOptedOutOfFax,
            Account.PersonHomePhone,
            Account.PersonIndividualId,
            Account.PersonLeadSource,
            Account.PersonMailingAddress,
            Account.PersonMailingCity,
            Account.PersonMailingCountry,
            Account.PersonMailingState,
            Account.PersonMailingStreet,
            Account.PersonMobilePhone,
            Account.PersonOtherAddress,
            Account.PersonOtherPhone,
            Account.Phone,
            Account.Rating,
            Account.RecordTypeId,
            Account.Vass_Rut__c
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the rut as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Account selectByRutWithLimit(String rut) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Vass_Rut__c = :rut');
        query.setLimit( 1 );
        return (Account) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the rut as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Account> selectByRutInAList(String rut) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Vass_Rut__c = :rut');
        query.setLimit( 1 );
        return (List<Account>) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Performs a query with fields defined in the method with the rut as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Account selectPersonAccountByRut(String rut) {
        return (Account) Database.query(
            newQueryFactory(false)
            .selectField(Account.FirstName)
            .selectField(Account.Id)
            .selectField(Account.IsPersonAccount)
            .selectField(Account.LastName)
            .selectField(Account.LP_AceptacionContratos__pc)
            .selectField(Account.LP_ApellidoMaterno__pc)
            .selectField(Account.LP_CupoDisponible__pc)
            .selectField(Account.LP_CreacionClaveInternet__pc)
            .selectField(Account.LP_CreadoOnboarding__pc)
            .selectField(Account.LP_EstadoCuentaMail__pc)
            .selectField(Account.LP_FechaPago__pc)
            .selectField(Account.LP_Genero__pc)
            .selectField(Account.LP_Nacionalidad__pc)
            .selectField(Account.LP_NumDeptoCasa__pc)
            .selectField(Account.LP_Ciudad__pc)
            .selectField(Account.LP_Ocupacion__pc)
            .selectField(Account.LP_Rut__c)
            .selectField(Account.LP_TipoTarjeta__pc)
            .selectField(Account.PersonBirthdate)
            .selectField(Account.PersonContactId)
            .selectField(Account.PersonDepartment)
            .selectField(Account.PersonDoNotCall)
            .selectField(Account.PersonEmail)
            .selectField(Account.PersonHasOptedOutOfEmail)
            .selectField(Account.PersonHasOptedOutOfFax)
            .selectField(Account.PersonHomePhone)
            .selectField(Account.PersonIndividualId)
            .selectField(Account.PersonLeadSource)
            .selectField(Account.PersonMailingAddress)
            .selectField(Account.PersonMailingCity)
            .selectField(Account.PersonMailingCountry)
            .selectField(Account.PersonMailingState)
            .selectField(Account.PersonMailingStreet)
            .selectField(Account.PersonMobilePhone)
            .selectField(Account.PersonOtherAddress)
            .selectField(Account.PersonOtherPhone)
            .selectField(Account.RecordTypeId)
            .selectField(Account.Vass_Rut__c)
            .setCondition('Vass_Rut__c = :rut')
            .toSOQL()
      );
    }
}