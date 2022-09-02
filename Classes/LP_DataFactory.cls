/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 09/06/2021
Description  : DataFactory contains all method for account, case, country, entitlement, and more object creations 
History      : PCRM- 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye     	RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			09/06/2021		initial version
********************************************************************************/

@isTest
public class LP_DataFactory {
	
    @TestVisible public static final String PRV_STR_B2C;    
    @TestVisible public static final String PRV_STR_B2B;
    @TestVisible public static final String PRV_PARAM_RUT_LEAD_ACCOUNT;
    @TestVisible public static final String PRV_PARAM_RUT_LEAD;
    @TestVisible public static final String PRV_PARAM_NAT_CL;
    @TestVisible public static final String PRV_PARAM_CITY_CL;
    @TestVisible public static final WrapperLeadData PRV_ONB_LEAD_WITHNO_CLIENT_CL;
    @TestVisible public static final WrapperLeadData PRV_ONB_LEAD_WITH_CLIENT_CL;
    @TestVisible public static final String PRV_BE_TARJETA_VISA;
    @TestVisible public static final String PRV_BE_TARJETA_TLP;
    @TestVisible public static final String PRV_ACC_TARJETA_VISA;
    @TestVisible public static final String PRV_ACC_TARJETA_TLP;
    @TestVisible public static final String PRV_ONB_DOCCODE_1;
    @TestVisible public static final String PRV_ONB_DOCCODE_2;
    @TestVisible public static final String PRV_ONB_DOCCODE_3;
    @TestVisible public static final String PRV_ONB_DOCCODE_4;
    @TestVisible public static final String PRV_ONB_DOCCODE_5;

    static {
        PRV_STR_B2C = 'PersonAccount';
        PRV_STR_B2B = 'Business_Account';
        PRV_PARAM_RUT_LEAD_ACCOUNT = '16246687-9';
        PRV_PARAM_RUT_LEAD = '10083142-2';
        PRV_PARAM_NAT_CL = 'CHILENA';
        PRV_PARAM_CITY_CL = 'SANTIAGO';
        PRV_ONB_LEAD_WITHNO_CLIENT_CL = new WrapperLeadData(false);
        PRV_ONB_LEAD_WITH_CLIENT_CL = new WrapperLeadData(true);
        PRV_BE_TARJETA_TLP = '0';
        PRV_BE_TARJETA_VISA = '1';
        PRV_ACC_TARJETA_TLP = '01';
        PRV_ACC_TARJETA_VISA = '02';
        PRV_ONB_DOCCODE_1 = 'CA80000002DB5E9CO2';   //Resumen Contrato Apertura
        PRV_ONB_DOCCODE_2 = 'CA80000002DB5E7CO2';   //Contrato Apertura Linea Credito
        PRV_ONB_DOCCODE_3 = 'CA80000002DB5E8MA2';   //Mandato
        PRV_ONB_DOCCODE_4 = 'CA80000002DB5E60_2';   //Autorización Especial
        PRV_ONB_DOCCODE_5 = 'CA80000002DB5EA8_2';   //Constancia De Suscripción Onboarding
    }

    /**
     * @description Warpper Class for Personal Data for Lead Records
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    public class WrapperLeadData {
        public String rut {get; set;}
        public String nombre {get; set;}
        public String primerApellido {get; set;}
        public String segundoApellido {get; set;}
        public String email {get; set;}
        public String mobilePhone {get; set;}
        public String nacionalidad {get; set;}
        public String tipo_tarjeta {get; set;}
        public Boolean hasClient {get; set;}

        public WrapperLeadData(Boolean hasClient) {
            if(hasClient) {                    // datos para registro lead CON cuenta
                this.rut = '16246687-9';
                //this.rut = '9978627-2';
                this.nombre = 'Jose Luis';
                this.primerApellido = 'Lobos';
                this.segundoApellido = 'Toro';
                this.email = 'notiene@notiene.cl';
                this.mobilePhone = '+56912341234';
                this.tipo_tarjeta = '01';
                System.debug('this.tipo_tarjeta: ' + this.tipo_tarjeta);
                this.hasClient = true;
            }
            else {                              // datos para registro lead SIN cuenta
                this.rut = '16449021-1';
                //this.rut = '9978629-9';
                this.nombre = 'Charles';
                this.primerApellido = 'Aránguiz';
                this.segundoApellido = 'Segundo';
                this.email = 'notiene@notiene.cl';
                this.mobilePhone = '+56912341234';
                this.tipo_tarjeta = '02';
                System.debug('this.tipo_tarjeta: ' + this.tipo_tarjeta);
                this.hasClient = false;
            }
            this.nacionalidad = PRV_PARAM_NAT_CL;
        }
    }

    /**
     * @description Create Data necesary for Step 6 Tests
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    public static void createLeadDataForOnboarding(WrapperLeadData personalData, String step) {
        // create nacionalidad record
        LP_Nacionalidad__c nat = createDefaultDataForNationality(personalData);
        // create base express record
        LP_Base_Express__c be = createDefaultDataForBaseExpress(personalData);
        // create lead record
        Lead l = createDefaultDataForLead(personalData, nat.id);
        // create account record
        String IdAcc = null;
        if (personalData.hasClient) {
            Account acc = createDefaultDataForAccount(personalData, nat.id);
            IdAcc = acc.Id;
        }
        // create onboarding record
        LP_Onboarding__c onb = createDefaultDataForOnboarding(personalData, l.id, IdAcc);
        // set values for step six
        if (step == LP_OnBoardingUtility.PBC_STR_STEPSIX) {
            setStep6DataForOnboarding(onb);
            setStep6DataForLead(l);
        }        
    }

    /**
    * @description create OnBoarding with burned phone for step 6
    * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    * @date        23/07/2021
    */
    public static void setStep6DataForOnboardingInvalidPhone(WrapperLeadData personalData) {
        LP_Onboarding__c ob = new LP_Onboarding__c();
        //ob.Name=OB-0000000137;
		ob.LP_Candidato__c = null;
        ob.LP_Cuenta__c = null;
        ob.LP_CorreoElectronico__c = personalData.email;
        ob.LP_TelefonoQuemado__c = clearPhonePrefix(personalData.mobilePhone);
        ob.LP_FirmaContratos__c = true;
        ob.LP_Score__c = 607;
        ob.CurrencyIsoCode = 'CLP';
        insert ob;
    }

    /**
    * @description Clear the phone prefix
    * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    * @date        23/07/2021
    */
    public static string clearPhonePrefix(String phone) {
        return phone.contains('+56') ? phone.split('\\+56')[1] : phone;
    }


    /**
     * @description Create Nationality / Private Method
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static LP_Nacionalidad__c createDefaultDataForNationality(WrapperLeadData personalData) {
        LP_Nacionalidad__c nac = new LP_Nacionalidad__c();
        nac.Name = personalData.nacionalidad;
        nac.LP_CodigoNacionalidad__c = 'CHL';
        nac.LP_Pais__c = 'Chile';
        nac.LP_Activo__c = true;
        upsert nac; 
        return nac;
    }

    /**
     * @description Create Base Express / Private Method
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static LP_Base_Express__c createDefaultDataForBaseExpress(WrapperLeadData personalData) {
        LP_Base_Express__c be = new LP_Base_Express__c();
        //be.Name=BE-000293104;
        be.CurrencyIsoCode='CLP';
        be.LP_Rut__c=personalData.rut.split('-')[0];
        be.LP_DV__c=personalData.rut.split('-')[1];
        be.LP_Cupo__c=100000;
        be.LP_OfertaTarjeta__c= personalData.tipo_tarjeta == PRV_ACC_TARJETA_VISA ? PRV_BE_TARJETA_VISA : PRV_BE_TARJETA_TLP;
        be.LP_TipoCliente__c='3';
        insert be;
        return be;
    }

    /**
     * @description Create OnBoarding / Private Method
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static LP_Onboarding__c createDefaultDataForOnboarding(WrapperLeadData personalData, Id leadId, Id accId) {
        LP_Onboarding__c ob = new LP_Onboarding__c();
        //ob.Name=OB-0000000137;
        ob.LP_Candidato__c = leadId;
        ob.LP_Cuenta__c = accId;
        ob.LP_CorreoElectronico__c = personalData.email;
        ob.LP_Score__c = 607;
        ob.CurrencyIsoCode = 'CLP';
        insert ob;
        return ob;
    }

    /**
     * @description Create Lead / Private Method
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static Lead createDefaultDataForLead(WrapperLeadData personalData, Id nationaliyId) {
        Lead leadRecord = new Lead();
        leadRecord.FirstName = personalData.nombre;
        leadRecord.LastName = personalData.primerApellido;
        leadRecord.LP_ApellidoMaterno__c = personalData.segundoApellido;
        leadRecord.LP_Rut__c = personalData.rut;
        leadRecord.LP_Nacionalidad__c = nationaliyId;
        leadRecord.Email = personalData.email;
        leadRecord.MobilePhone = personalData.mobilePhone;
        leadRecord.LP_TipoTarjeta__c = personalData.tipo_tarjeta;
        leadRecord.LP_Genero__c = 'Masculino';
        leadRecord.CurrencyIsoCode='CLP';
        insert leadRecord;
        return leadRecord;
    }

    /**
     * @description Create Account / Private Method
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static Account createDefaultDataForAccount(WrapperLeadData personalData, Id nationaliyId) {
        Account acc = new Account();
        acc.FirstName = personalData.nombre;
        acc.LastName = personalData.primerApellido;
        acc.LP_ApellidoMaterno__pc = personalData.segundoApellido;
        acc.Vass_Rut__c  = personalData.rut;
        acc.LP_Rut__c  = personalData.rut;        
        acc.LP_Nacionalidad__pc = nationaliyId;
        acc.PersonEmail = personalData.email;
        acc.PersonMobilePhone = personalData.mobilePhone;
        acc.Phone = clearPhonePrefix(personalData.mobilePhone);
        acc.LP_TipoTarjeta__pc = personalData.tipo_tarjeta;
        acc.LP_Genero__pc = 'Masculino';
        acc.CurrencyIsoCode = 'CLP';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        insert acc;
        return acc;
    }

    /**
     * @description Update OnBoarding for step 6
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static void setStep6DataForOnboarding(LP_Onboarding__c obParam) {
        LP_OnBoarding__c ob = new LP_Onboarding__c();
        ob.id = obParam.id;
        // pre-steps
        ob.LP_Ruta__c=LP_OnBoardingUtility.PBC_STR_STEPFIVE;
        ob.LP_AceptacionContratos__c=true;
        ob.LP_AceptacionTerminosCondiciones__c=true;
        ob.LP_CorreoValidado__c=true;
        ob.LP_ValidacionIdentidadCompletada__c=true;       
        ob.LP_GUIDIdentCheck__c='1bb5d8ca-4e78-00df-ee6d-7e3c997dbaa9';
        ob.LP_BaseExpressValidado__c=true;
        ob.LP_IdentificacionLavadoActivos__c='0';
        ob.LP_InformesComercialesValidado__c=true;
        ob.LP_LavadoActivosValidado__c=true;
        ob.LP_CodigoOTPEmail__c='666872';
        ob.LP_ValidacionIdentidadCompletadaExitosa__c=false;
        ob.LP_DatosPersonalesCompletados__c=true;
        ob.LP_CodigoResumenContratoApertura__c = PRV_ONB_DOCCODE_1;
        ob.LP_CodigoContratoApertura__c = PRV_ONB_DOCCODE_2;
        ob.LP_CodigoMandato__c = PRV_ONB_DOCCODE_3;
        ob.LP_CodigoAutorizacionEspecial__c = PRV_ONB_DOCCODE_4;
        ob.LP_CodigoConstanciaSuscripcion__c = PRV_ONB_DOCCODE_5;
        //Step 6 
        ob.LP_CodigoOTP__c=null;
        ob.LP_TelefonoQuemado__c='';
        ob.LP_FirmaContratos__c=false;
        update ob;
    }

    /**
     * @description Update Lead for step 6
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static void setStep6DataForLead(Lead leadParam) {
        lead l = new Lead();
        l.id = leadParam.id;
        // pre steps
        l.LP_CreadoOnboarding__c=true;
        l.Street='Avenida María Rozas Velásquez';
        l.City='Quinta Normal';
        l.State='Santiago';
        l.Country='Chile';
        l.Status='Working';
        l.LP_Ciudad__c=null;
        l.LP_Ocupacion__c='Trabajador Dependiente de otras áreas';
        l.LP_NivelEducacional__c='Universitaria completa';
        l.LP_EstadoCuentaMail__c=true;
        l.LP_CupoDisponible__c=500000;
        l.LP_FechaPago__c='5';
        // step 6
        l.LP_NumeroCelularValidado__c=false;
        l.LP_FirmaContratos__c=false;
        l.LP_CodigoOTP__c=null;
        update l;
    }

    /**
     * @description Update Account for step 6
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        23/07/2021
     */
    private static void setStep6DataForAccount(Account accParam) {
        Account acc = new Account();
        acc.id = accParam.id;
        // pre-steps
        acc.LP_RutaOnboarding__pc=LP_OnBoardingUtility.PBC_STR_STEPFIVE;
        acc.LP_CreadoOnboarding__pc=false;
        acc.LP_CuentaCreadaSitios__pc=false;
        acc.LP_Ciudad__pc=null;
        acc.LP_Ocupacion__pc='Trabajador Dependiente de otras áreas';
        acc.LP_CupoDisponible__pc=500000;
        acc.LP_FechaPago__pc='5';
        acc.LP_EstadoCuentaMail__pc=true;
        acc.LP_NivelEducacional__pc='Universitaria completa';
        acc.LP_AceptacionContratos__pc=true;
        // step 6
        acc.LP_CodigoOTP__pc=null;
        acc.LP_FechaFirmaContratos__pc=null;
        acc.LP_FechaNumeroCelular__pc=null;
        acc.LP_FechaCodigoOTP__pc=null;
        acc.LP_NumeroCelularValidado__pc=false;
        acc.LP_FirmaContratos__pc=true;
        acc.LP_CreacionClaveInternet__pc=false;
        update acc;
    }

    /**
     * @description Create Nationality
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */
    public static LP_Nacionalidad__c createNationalityCL(Boolean doInsert) {
        LP_Nacionalidad__c nac = new LP_Nacionalidad__c();
        nac.Name = PRV_PARAM_NAT_CL;
        nac.LP_CodigoNacionalidad__c = 'CHL';
        nac.LP_Pais__c = 'Chile';
        nac.LP_Activo__c = true;
        insert nac; 
        return nac;
    }

    /**
     * @description Create City
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */    
    public static LP_Ciudad__c createCityCL(Boolean doInsert){
        LP_Ciudad__c city = new LP_Ciudad__c();
        city.Name = PRV_PARAM_CITY_CL;
        city.LP_Codigo__c = '7Q';
        insert city; 
        return city;
        
    }

    /**
     * @description Create Lead
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */
    public static void createAccountAndLeadWithRUT(Boolean doInsert, LP_Nacionalidad__c nationality) {
        Account acc = new Account();
        acc.FirstName = 'Jose Luis';
        acc.LastName = 'Lobos';
        acc.LP_ApellidoMaterno__pc = 'Toro';
        acc.Vass_Rut__c = PRV_PARAM_RUT_LEAD_ACCOUNT;
        acc.LP_Rut__c = PRV_PARAM_RUT_LEAD_ACCOUNT;        
        acc.LP_Nacionalidad__pc = nationality.id;
        acc.LP_Genero__pc = 'Masculino';
        acc.PersonEmail = 'notiene@notiene.cl';
        acc.PersonMobilePhone = '+56945324567';
        acc.Phone = '+56945324567';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        insert acc;
        
        Lead leadRecord = new Lead();
        leadRecord.FirstName = 'Pedro Perez';
        leadRecord.LastName = 'Moya';
        leadRecord.LP_ApellidoMaterno__c = 'Mora';
        leadRecord.LP_Rut__c = PRV_PARAM_RUT_LEAD_ACCOUNT;
        leadRecord.LP_Nacionalidad__c = nationality.id;
        leadRecord.LP_Genero__c = 'Masculino';
        leadRecord.Email = 'notiene@notiene.cl';
        leadRecord.MobilePhone = '+56945324567';
        insert leadRecord;
    }

    /**
    * @Description: Create Account
    * @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    * @Date:        16/06/2021
    */
    public static Account createAccount(Boolean doInsert, LP_Nacionalidad__c nationality) {
        Account acc = new Account();
        acc.FirstName = 'Jose Luis';
        acc.LastName = 'Lobos';
        acc.LP_ApellidoMaterno__pc = 'Toro';
        acc.LP_Rut__c = PRV_PARAM_RUT_LEAD_ACCOUNT;
        acc.Vass_Rut__c = PRV_PARAM_RUT_LEAD_ACCOUNT;   
        acc.LP_Nacionalidad__pc = nationality.id;
        acc.LP_Genero__pc = 'Masculino';
        acc.PersonEmail = 'notiene@notiene.cl';
        acc.PersonMobilePhone = '+56945324567';
        acc.Phone = '+56945324567';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        insert acc;
        return acc;
    }

    
    /**
     * @description Create Lead
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */
    public static void createLeadBaseExpressWithRUT(Boolean doInsert, LP_Nacionalidad__c nationality) {      
        Lead leadRecord = new Lead();
        leadRecord.FirstName = 'Juan Orlando';
        leadRecord.LastName = 'Lopez';
        leadRecord.LP_ApellidoMaterno__c = 'Hernandez';
        leadRecord.LP_Rut__c = PRV_PARAM_RUT_LEAD;
        leadRecord.LP_Nacionalidad__c = nationality.id;
        leadRecord.LP_Genero__c = 'Masculino';
        leadRecord.Email = 'notiene2@notiene.cl';
        leadRecord.MobilePhone = '+56945324561';
        insert leadRecord;

        LP_Base_Express__c be = new LP_Base_Express__c();
        //be.Name
        List<String> parts = PRV_PARAM_RUT_LEAD.split('-');
        be.LP_Rut__c = parts[0];
        be.LP_DV__c = parts[1];
        be.LP_TipoCliente__c = '1';
        be.LP_Cupo__c = 100000;
        insert be;
    }

    /**
     * @description Create Lead
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */
    public static Lead createLeadWithRUT(Boolean doInsert, LP_Nacionalidad__c nationality) {
        Lead leadRecord = new Lead();
        leadRecord.FirstName = 'Maria Luisa';
        leadRecord.LastName = 'Rosas';
        leadRecord.LP_ApellidoMaterno__c = 'Troncoso';
        leadRecord.LP_Rut__c = PRV_PARAM_RUT_LEAD;
        leadRecord.LP_Nacionalidad__c = nationality.id;
        leadRecord.LP_Genero__c = 'Femenino';
        leadRecord.Email = 'notiene@notiene.cl';
        leadRecord.MobilePhone = '+56945324567';
        leadRecord.LP_FechaPago__c = '5';
        insert leadRecord;
        return leadRecord;
    }

    /**
     * @description Create Lead
     * @author      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
     * @date        09/06/2021
     */
    public static LP_Onboarding__c createLP_Onboarding(Boolean doInsert, lead objLead) {
        LP_Onboarding__c objOnb = new LP_Onboarding__c();
        objOnb.LP_Ruta__c = 'paso-2';
        objOnb.LP_CorreoElectronico__c = 'pepito@pagadoble.cl';
        objOnb.LP_Candidato__c = objLead.Id;
        objOnb.LP_FechaNacimiento__c = Date.newInstance(1991, 10, 10);
        insert objOnb;
        return objOnb;
    }

    /**
    * @Description: Create Onboarding with Account record
    * @Autor:       Abdón Tejos, Deloitte, atejoso@deloitte.com
    * @Date:        16/06/2021
    */
    public static LP_Onboarding__c createOnboardingWithAcc(Boolean doInsert, Account acc) {
        LP_Onboarding__c objOnb = new LP_Onboarding__c();
        objOnb.LP_Ruta__c = 'paso-2';
        objOnb.LP_CorreoElectronico__c = 'pepito@pagadoble.cl';
        objOnb.LP_Cuenta__c = acc.Id;
        insert objOnb;
        return objOnb;
    }
    
    /**
    * @Description: Create Private Site Account
    * @Autor:       Damian Biaggio, Deloitte, atejoso@deloitte.com
    * @Date:        30/06/2021
    */
    public static Account createAccount(){
        LP_Nacionalidad__c nac = new LP_Nacionalidad__c();
        nac.Name = PRV_PARAM_NAT_CL;
        nac.LP_CodigoNacionalidad__c = 'CHL';
        nac.LP_Pais__c = 'Chile';
        nac.LP_Activo__c = true;
        insert nac; 

    	Account acc1 = new Account();
    	acc1.FirstName = 'Test';
    	acc1.LastName = 'prueba' + ' ' + 'piloto';
        acc1.Vass_Rut__c = '10083142-2';
        acc1.LP_Rut__c = '10083142-2';        
        acc1.LP_ApellidoMaterno__pc = 'Troncoso';
    	acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        acc1.PersonMobilePhone = '+56945324567';
        acc1.PersonEmail = 'notiene@notiene.cl';
        acc1.LP_Genero__pc = 'Masculino';
        acc1.LP_Nacionalidad__pc = nac.id;
        //acc1.OwnerId = '005020000017jqGAAQ';
        insert acc1;
    	return acc1;
    }

    public static Account createBusinessAccount(){
        LP_Nacionalidad__c nac = new LP_Nacionalidad__c();
        nac.Name = PRV_PARAM_NAT_CL;
        nac.LP_CodigoNacionalidad__c = 'CHL';
        nac.LP_Pais__c = 'Chile';
        nac.LP_Activo__c = true;
        insert nac; 

    	Account acc1 = new Account();
    	acc1.Name = 'TestAccount2';
    	acc1.Vass_Rut__c = '10083142-2';
        acc1.LP_Rut__c = '10083142-2';
    	acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Cuenta_Principal').getRecordTypeId();
        acc1.AccountNumber='A2';
        acc1.AnnualRevenue=12345.67;
        insert acc1;
    	return acc1;
    }
    
    /**
    * @Description: Create Private Site User
    * @Autor:       Damian Biaggio, Deloitte, atejoso@deloitte.com
    * @Date:        30/06/2021
    */
    public static User createUser(Account acc1){
        User user = new User();
        Profile pro = [Select id from Profile where name = 'Customer Community User Sitio Privado'];
        user.FirstName = 'Test';
        user.LastName = 'prueba' + ' ' + 'piloto';
        user.IsActive = true;
        user.Email = 'german@gmail.com';
        user.Username = 'german@gmail.com' + '.LaPolar2';
        user.CommunityNickname = 'german@gmail.com' +'2';
        user.ProfileId = pro.id;            
        Contact cont = [Select Id, name from Contact where AccountId = :acc1.Id];
        user.ContactId = cont.Id;
        user.Phone = '12345678';
        user.RUT__c = '10083142-2';
        user.Alias = 'alias1';
        user.TimeZoneSidKey = 'America/Santiago'; // Required
        user.LocaleSidKey = 'en_US'; // Required
        user.EmailEncodingKey = 'ISO-8859-1'; // Required
        user.LanguageLocaleKey = 'en_US'; // Required
        insert (user);
        return user;
    }
    
     /**
    * @Description: Create Private Site User
    * @Autor:       Damian Biaggio, Deloitte, atejoso@deloitte.com
    * @Date:        30/06/2021
    */
    public static User createUserBlocked(Account acc1){
        User user = new User();
        Profile pro = [Select id from Profile where name = 'Customer Community User Sitio Privado'];
        user.FirstName = 'Test';
        user.LastName = 'prueba' + ' ' + 'piloto';
        user.IsActive = true;
        user.Email = 'german@gmail.com';
        user.Username = 'german@gmail.com' + '.LaPolar2';
        user.CommunityNickname = 'german@gmail.com' +'2';
        user.ProfileId = pro.id;            
        Contact cont = [Select Id, name from Contact where AccountId = :acc1.Id];
        user.ContactId = cont.Id;
        user.Phone = '12345678';
        user.RUT__c = '10083142-2';
        user.Alias = 'alias1';
        user.TimeZoneSidKey = 'America/Santiago'; // Required
        user.LocaleSidKey = 'en_US'; // Required
        user.EmailEncodingKey = 'ISO-8859-1'; // Required
        user.LanguageLocaleKey = 'en_US'; // Required
        user.Is_Blocked__c = true;
        user.Blocked_Time__c = DateTime.now();
        insert (user);
        return user;
    }
    
    /**
    * @Description: Create Private Site User
    * @Autor:       Damian Biaggio, Deloitte, atejoso@deloitte.com
    * @Date:        30/06/2021
    */
    public static User createUserLogin(Account acc1){
        User user = new User();
        Profile pro = [Select id from Profile where name = 'Customer Community User Sitio Privado'];
        user.FirstName = 'Test';
        user.LastName = 'prueba' + ' ' + 'piloto';
        user.IsActive = true;
        user.Email = 'damian@gmail.com';
        user.Username = 'damian@gmail.com' + '.LaPolar2';
        user.CommunityNickname = 'damian@gmail.com' +'2';
        user.ProfileId = pro.id;            
        Contact cont = [Select Id, name from Contact where AccountId = :acc1.Id];
        user.ContactId = cont.Id;
        user.Phone = '12345678';
        user.RUT__c = '19246239-8';
        user.Alias = 'alias1';
        user.TimeZoneSidKey = 'America/Santiago'; // Required
        user.LocaleSidKey = 'en_US'; // Required
        user.EmailEncodingKey = 'ISO-8859-1'; // Required
        user.LanguageLocaleKey = 'en_US'; // Required
        insert (user);
        return user;
    }

    public static Case createCase(Account cuenta){
    	Case cas = new Case();
        cas.AccountId = cuenta.id;
    	cas.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('LP_ConsultaRF').getRecordTypeId();
        cas.LP_Nivel1__c = 'Cobranza';
        cas.LP_Nivel2__c = 'Opciones de Pago';
        cas.LP_Nivel3__c = 'Información Para Realizar Repactación u Opción de Pago';
        cas.LP_Canal__c = 'Call Center';
        cas.LP_Subcanal__c = 'SAC';
        cas.Description = 'Description,Description,Description,Description,Description,Description';
        insert cas;
    	return cas;
    }

    public static Lead getLeadFromRUT(String rut){
        return new LP_LeadsSelector().selectByRutWithLimit(rut);
    }

    public static LP_Onboarding__c getOnBoardingFromLead(lead objectLead){
        return new LP_OnboardingSelector().selectByLeadIdWithLimit(objectLead.Id);    
    }

     /**
     * @description Create EmailTemplate
     * @author      Laura Malavé, Deloitte, lmalaveb@deloitte.com
     * @date        17/08/2021
     */
    public static EmailTemplate createEmailTemplate(Boolean doInsert, User usr) {
        EmailTemplate validEmailTemplate = new EmailTemplate();
        validEmailTemplate.isActive = true;
        validEmailTemplate.Name = 'name';
        validEmailTemplate.DeveloperName = 'Email_First_Response';
        validEmailTemplate.TemplateType = 'text';
        validEmailTemplate.FolderId = usr.Id;
        validEmailTemplate.Subject = 'Your Subject Here';
                
        insert validEmailTemplate;
        return validEmailTemplate;
    }

}