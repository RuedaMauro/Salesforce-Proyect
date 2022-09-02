/**
  * -------------------------------------------------------------------------------------------------
  * @Name   CRM_Case_Service_Test
  * @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
  * @Date   Created: 2021-11-17
  * @Group  Form Conversion
  * -------------------------------------------------------------------------------------------------
  * @Description This public class tests the CRM_Case_Service class
  * -------------------------------------------------------------------------------------------------
  * @Changes
  *
  **/
@istest
public class CRM_Case_Service_Test {
    /**
      * @Description Test method for private form (account and case creation)
      **/
    @isTest public static void handleInboundEmailToAccountTest() {
      User contextUser = getContextUser();
      System.runAs(contextUser){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.subject = 'Contacto FNB: 23953  - Consulta o pedido - Cierre / Baja - Tarjeta credito';
        email.toAddresses = new List<String>{'galo.guardia.contractor@gdevtools.com'};
        email.plainTextBody = 'Nombre: Juan\n Enviado desde: BANCA ONLINE\n Contacto Nro: 23912\n Nro. de Documento: 37007324\n Email: hola@bbva.com\n Teléfono: 11-4242-4242\n Horario: 08 a 11 hs\n Tipo Mensaje: Reclamo o queja\n Mensaje: Prueba Sistemas.\n';
        env.fromAddress = 'user@acme.com';

        Test.startTest();
        CRM_Case_Service emailToLeadService = new CRM_Case_Service();
        Messaging.InboundEmailResult result = emailToLeadService.handleInboundEmail(email, env);
        Test.stopTest();

        System.assertEquals(result.success, true, result.message);
      }
    }

    /**
      * @Description Test method for public form (contact and case creation)
      **/
    @isTest public static void handleInboundEmailToContactTest() {
      User contextUser = getContextUser();
      System.runAs(contextUser){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.subject = '[TEST] - Contacto N°: 268 - RECLAMO - Tarjeta credito';
        email.toAddresses = new List<String>{'galo.guardia.contractor@gdevtools.com'};
        email.plainTextBody = 'Nombre: Juan\n Enviado desde: "Sitio Público"\n Contacto Nro: 23912\n Nro. de Documento: 37007324\n Email: hola@bbva.com\n Teléfono: 11-4242-4242\n Horario: 08 a 11 hs\n Tipo Mensaje: Reclamo o queja\n Mensaje: Prueba Sistemas.\n';
        env.fromAddress = 'user@acme.com';

        Test.startTest();
        CRM_Case_Service emailToLeadService = new CRM_Case_Service();
        Messaging.InboundEmailResult result = emailToLeadService.handleInboundEmail(email, env);
        Test.stopTest();

        System.assertEquals(result.success, true, result.message);
      }
    }

    /**
      * @Description Test method for general error
      **/
    @isTest public static void handleInboundEmailErrorTest() {
      User contextUser = getContextUser();
      System.runAs(contextUser){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.subject = 'Contacto FNB: 23953  - Consulta o pedido - Cierre / Baja - Tarjeta credito';
        email.toAddresses = new List<String>{'galo.guardia.contractor@gdevtools.com'};
        email.plainTextBody = 'Nombre: \n Enviado desde: "Sitio Público"\n Contacto Nro: 23912\n Nro. de Documento: 37007324\n Email: hola@bbva.com\n Teléfono: 11-4242-4242\n Tipo Mensaje: Hola\n Mensaje: Prueba Sistemas.\n';
        env.fromAddress = 'user@acme.com';

        Test.startTest();
        CRM_Case_Service emailToLeadService = new CRM_Case_Service();
        Messaging.InboundEmailResult result = emailToLeadService.handleInboundEmail(email, env);
        Test.stopTest();

        System.assertEquals(result.success, false, result.message);
      }
    }

    /**
      * @Description Test method for missing fields error
      **/
    @isTest public static void handleInboundEmailErrorMissingFieldsTest() {
      User contextUser = getContextUser();
      System.runAs(contextUser){
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.subject = 'Contacto FNB: 23953  - Consulta o pedido - Cierre / Baja - Tarjeta credito';
        email.toAddresses = new List<String>{'galo.guardia.contractor@gdevtools.com'};
        email.plainTextBody = '';
        env.fromAddress = 'user@acme.com';

        Test.startTest();
        CRM_Case_Service emailToLeadService = new CRM_Case_Service();
        Messaging.InboundEmailResult result = emailToLeadService.handleInboundEmail(email, env);
        Test.stopTest();

        System.assertEquals(result.success, false, result.message);
      }
    }

    private static User getContextUser(){
      Profile minimumAccessProfile = [SELECT Id FROM Profile WHERE Name='Minimum Access - Salesforce'];
      User contextUser = new User(
            Username = 'test-user@bbva.com.ar',
            LastName = 'test',
            Email = 'test-user@bbva.com.ar',
            Alias = 'testusr',
            TimeZoneSidKey = 'America/Argentina/Buenos_Aires',
            LocaleSidKey = 'es_AR',
            EmailEncodingKey = 'UTF-8',
            ProfileId = minimumAccessProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert contextUser;
        PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'CRM_SCC_SocialSystemAdmin'];

        insert new PermissionSetAssignment(AssigneeId = contextUser.id, PermissionSetId = ps.Id);

        return contextUser;
    }
}