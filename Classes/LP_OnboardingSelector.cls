/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 01/06/2021
Description  : Query factory for Onboarding using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			01/06/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingSelector extends fflib_SObjectSelector{

    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public Schema.SObjectType getSObjectType(){
        return LP_Onboarding__c.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            LP_Onboarding__c.CreatedDate,
            LP_Onboarding__c.CurrencyIsoCode,
            LP_Onboarding__c.Id,
            LP_Onboarding__c.LP_AceptacionContratos__c,
            LP_Onboarding__c.LP_AceptacionTerminosCondiciones__c,
            LP_Onboarding__c.LP_ApellidosValidacionBiometrica__c,
            LP_Onboarding__c.LP_BaseExpressValidado__c,
            LP_Onboarding__c.LP_Candidato__c,
            LP_Onboarding__c.LP_CodigoOTPEmail__c,
            LP_Onboarding__c.LP_CodigoOTP__c,
            LP_Onboarding__c.LP_CodigoAutorizacionEspecial__c,
            LP_Onboarding__c.LP_CodigoContratoApertura__c,
            LP_Onboarding__c.LP_CodigoMandato__c,
            LP_Onboarding__c.LP_CodigoResumenContratoApertura__c,
            LP_Onboarding__c.LP_CodigoConstanciaSuscripcion__c,
            LP_Onboarding__c.LP_CorreoElectronico__c,
            LP_Onboarding__c.LP_CorreoValidado__c,
            LP_Onboarding__c.LP_Cuenta__c,
            LP_Onboarding__c.LP_FechaEmisionCedulaIdentidad__c,
            LP_Onboarding__c.LP_FechaNacimiento__c,
            LP_Onboarding__c.LP_FechaVencimientoCedulaIdentidad__c,
            LP_Onboarding__c.LP_FirmaContratos__c,
            LP_Onboarding__c.LP_GUIDIdentCheck__c,
            LP_Onboarding__c.LP_IdentificacionLavadoActivos__c,
            LP_Onboarding__c.LP_InformesComercialesValidado__c,
            LP_Onboarding__c.LP_LavadoActivosValidado__c,
            LP_Onboarding__c.LP_NacionalidadValidacionBiometrica__c,
            LP_Onboarding__c.LP_NombresValidacionBiometrica__c,
            LP_Onboarding__c.LP_NumeroDocumento__c,
            LP_Onboarding__c.LP_Ruta__c,
            LP_Onboarding__c.LP_RutValidacionBiometrica__c,
            LP_Onboarding__c.LP_Score__c,
            LP_Onboarding__c.LP_Sexo__c,
            LP_Onboarding__c.LP_ValidacionIdentidadCompletada__c,
            LP_Onboarding__c.LP_ValidacionIdentidadCompletadaExitosa__c,
            LP_Onboarding__c.Name
        };
    }

    /**
    *  @Description: Perform a query with the default fields with set of Ids as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public List<LP_Onboarding__c> selectById(Set<Id> recordIds){
        return (List<LP_Onboarding__c>) selectSObjectsById(recordIds);
    }

    /**
    *  @Description: Perform a query with the default fields with the Id of Lead as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Onboarding__c selectByLeadIdWithLimit(Id leadId){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_Candidato__c = :leadId');
        query.setLimit( 1 );
        return (LP_Onboarding__c) Database.query( query.toSOQL() );
    }
    
    /**
    *  @Description: Perform a query with the default fields with the RUT of Lead as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Onboarding__c selectByLeadRutWithLimit(String leadRut){
        fflib_QueryFactory query = newQueryFactory();
        fflib_SObjectSelector leadSelector = new LP_LeadsSelector();
        leadSelector.configureQueryFactoryFields(query, 'LP_Candidato__r');
        query.setCondition('LP_Candidato__r.LP_Rut__c = :leadRut');
        query.setLimit( 1 );
        return (LP_Onboarding__c) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the Id of Account as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Onboarding__c selectByAccountIdWithLimit(Id accId){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_Cuenta__c = :accId');
        query.setLimit( 1 );
        return (LP_Onboarding__c) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Perform a query with the default fields with the Id of Account as a condition
    *  @Autor:       Eilhert Andrade, Deloitte, eandrade@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Onboarding__c selectByGUIDWithLimit(String guid){
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('LP_GUIDIdentCheck__c = :guid');
        query.setLimit( 1 );
        return (LP_Onboarding__c) Database.query( query.toSOQL() );
    }

    /**
    *  @Description: Performs a query with fields defined in the method with the RUT of Account as a condition
    *  @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        01/06/2021
    */
    public LP_Onboarding__c selectByAccountRutWithLimit(String accRut){
        Boolean isPersonAcc = true;
        return (LP_Onboarding__c) Database.query(
            newQueryFactory(false)
            .selectField(LP_Onboarding__c.CreatedDate)
            .selectField(LP_Onboarding__c.CurrencyIsoCode)
            .selectField(LP_Onboarding__c.Id)
            .selectField(LP_Onboarding__c.LP_AceptacionContratos__c)
            .selectField(LP_Onboarding__c.LP_AceptacionTerminosCondiciones__c)
            .selectField(LP_Onboarding__c.LP_ApellidosValidacionBiometrica__c)
            .selectField(LP_Onboarding__c.LP_BaseExpressValidado__c)
            .selectField(LP_Onboarding__c.LP_Candidato__c)
            .selectField(LP_Onboarding__c.LP_CodigoOTPEmail__c)
            .selectField(LP_Onboarding__c.LP_CodigoOTP__c)
            .selectField(LP_Onboarding__c.LP_CodigoAutorizacionEspecial__c)
            .selectField(LP_Onboarding__c.LP_CodigoContratoApertura__c)
            .selectField(LP_Onboarding__c.LP_CodigoMandato__c)
            .selectField(LP_Onboarding__c.LP_CodigoResumenContratoApertura__c)
            .selectField(LP_Onboarding__c.LP_CodigoConstanciaSuscripcion__c)
            .selectField(LP_Onboarding__c.LP_CorreoElectronico__c)
            .selectField(LP_Onboarding__c.LP_CorreoValidado__c)
            .selectField(LP_Onboarding__c.LP_Cuenta__c)
            .selectField(LP_Onboarding__c.LP_FechaEmisionCedulaIdentidad__c)
            .selectField(LP_Onboarding__c.LP_FechaNacimiento__c)
            .selectField(LP_Onboarding__c.LP_FechaVencimientoCedulaIdentidad__c)
            .selectField(LP_Onboarding__c.LP_FirmaContratos__c)
            .selectField(LP_Onboarding__c.LP_GUIDIdentCheck__c)
            .selectField(LP_Onboarding__c.LP_IdentificacionLavadoActivos__c)
            .selectField(LP_Onboarding__c.LP_InformesComercialesValidado__c)
            .selectField(LP_Onboarding__c.LP_LavadoActivosValidado__c)
            .selectField(LP_Onboarding__c.LP_NacionalidadValidacionBiometrica__c)
            .selectField(LP_Onboarding__c.LP_NombresValidacionBiometrica__c)
            .selectField(LP_Onboarding__c.LP_NumeroDocumento__c)
            .selectField(LP_Onboarding__c.LP_Ruta__c)
            .selectField(LP_Onboarding__c.LP_RutValidacionBiometrica__c)
            .selectField(LP_Onboarding__c.LP_Score__c)
            .selectField(LP_Onboarding__c.LP_Sexo__c)
            .selectField(LP_Onboarding__c.LP_ValidacionIdentidadCompletada__c)
            .selectField(LP_Onboarding__c.LP_ValidacionIdentidadCompletadaExitosa__c)
            .selectField(LP_Onboarding__c.Name)
            .selectField('LP_Cuenta__r.FirstName')
            .selectField('LP_Cuenta__r.Id')
            .selectField('LP_Cuenta__r.IsPersonAccount')
            .selectField('LP_Cuenta__r.LastName')
            .selectField('LP_Cuenta__r.LP_AceptacionContratos__pc')
            .selectField('LP_Cuenta__r.LP_ApellidoMaterno__pc')
            .selectField('LP_Cuenta__r.LP_CodigoOTP__pc')
            .selectField('LP_Cuenta__r.LP_CupoDisponible__pc')
            .selectField('LP_Cuenta__r.LP_CreacionClaveInternet__pc')
            .selectField('LP_Cuenta__r.LP_CreadoOnboarding__pc')
            .selectField('LP_Cuenta__r.LP_EstadoCuentaMail__pc')
            .selectField('LP_Cuenta__r.LP_FechaPago__pc')
            .selectField('LP_Cuenta__r.LP_Genero__pc')
            .selectField('LP_Cuenta__r.LP_Nacionalidad__pc')
            .selectField('LP_Cuenta__r.LP_NumDeptoCasa__pc')
            .selectField('LP_Cuenta__r.LP_Ciudad__pc')
            .selectField('LP_Cuenta__r.LP_Ocupacion__pc')
            .selectField('LP_Cuenta__r.LP_Rut__c')
            .selectField('LP_Cuenta__r.LP_TipoTarjeta__pc')
            .selectField('LP_Cuenta__r.PersonBirthdate')
            .selectField('LP_Cuenta__r.PersonContactId')
            .selectField('LP_Cuenta__r.PersonDepartment')
            .selectField('LP_Cuenta__r.PersonDoNotCall')
            .selectField('LP_Cuenta__r.PersonEmail')
            .selectField('LP_Cuenta__r.PersonHasOptedOutOfEmail')
            .selectField('LP_Cuenta__r.PersonHasOptedOutOfFax')
            .selectField('LP_Cuenta__r.PersonHomePhone')
            .selectField('LP_Cuenta__r.PersonIndividualId')
            .selectField('LP_Cuenta__r.PersonLeadSource')
            .selectField('LP_Cuenta__r.PersonMailingAddress')
            .selectField('LP_Cuenta__r.PersonMailingCity')
            .selectField('LP_Cuenta__r.PersonMailingCountry')
            .selectField('LP_Cuenta__r.PersonMailingState')
            .selectField('LP_Cuenta__r.PersonMailingStreet')
            .selectField('LP_Cuenta__r.PersonMobilePhone')
            .selectField('LP_Cuenta__r.PersonOtherAddress')
            .selectField('LP_Cuenta__r.PersonOtherPhone')
            .selectField('LP_Cuenta__r.RecordTypeId')
            .selectField('LP_Cuenta__r.Vass_Rut__c')
            .setCondition('LP_Cuenta__r.LP_Rut__c = :accRut OR LP_Cuenta__r.Vass_Rut__c = :accRut')
            .setLimit( 1 )
            .toSOQL()
            );
    }

    /**
    *  @Description: Performs a query with fields defined in the method with the Id of Oboarding record as condition
    *  @Author:      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    public LP_Onboarding__c selectByOnboardingIdWithLimit(String idParam){
        return (LP_Onboarding__c) Database.query(
            newQueryFactory(false)
            .selectField(LP_Onboarding__c.Id)
            .selectField(LP_Onboarding__c.LP_Candidato__c)
            .selectField(LP_Onboarding__c.LP_Cuenta__c)
            .setCondition('Id = :idParam')
            .setLimit( 1 )
            .toSOQL()
            );
    }

    /**
    *  @Description: Performs a query with fields defined in the method with mobilePhone of Oboarding record as condition
    *  @Author:      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        21/07/2021
    */
    public LP_Onboarding__c selectByOnboardingMobilePhoneWithLimit(String paramMobilePhone){
        return (LP_Onboarding__c) Database.query(
            newQueryFactory(false)
            .selectField(LP_Onboarding__c.Id)
            .selectField(LP_Onboarding__c.LP_Candidato__c)
            .selectField(LP_Onboarding__c.LP_Cuenta__c)
            .selectField(LP_Onboarding__c.LP_TelefonoQuemado__c)
            .selectField(LP_Onboarding__c.LP_FirmaContratos__c)
            .setCondition('LP_TelefonoQuemado__c = :paramMobilePhone AND LP_FirmaContratos__c = true')
            .setLimit( 1 )
            .toSOQL()
            );
    }
}