/**
* -------------------------------------------------------------------------------------------------
* @Name   CRM_Utils_Service_Test
* @Author Galo Guardia   galo.guardia.contractor@gdevtools.com
* @Date   Created: 2022-01-06
* @Group  Util
* -------------------------------------------------------------------------------------------------
* @Description This public class tests the CRM_Utils_Service class
* -------------------------------------------------------------------------------------------------
* @Changes
*
**/
@istest
public class CRM_Utils_Service_Test {
    /**
    * @Description Test method for missing fields in the conversion of the form to case
    **/
    @isTest public static void checkRequiredFieldsForFormConversionTest() {
        User contextUser = getContextUser();
        System.runAs(contextUser) {
            Map<String, String> fields = new Map<String, String>{
                'Nombre' => 'Nombre:'
            };
            final String regex_Nombre = '(' + fields.get('Nombre') + ')'+ '.+';
            Map<String, Matcher> matchers = new Map<String, Matcher>{
                'Nombre' => Pattern.compile(regex_Nombre).matcher('body')
            };

            Test.startTest();
            CRM_Utils_Service utilService = new CRM_Utils_Service();
            List<String> result = utilService.checkRequiredFieldsForFormConversion(fields, matchers, 'Nombre');
            Test.stopTest();

            System.assertEquals(result, new List<String>{'Nombre'}, 'Hay campos obligatorios faltantes: Nombre');
        }
    }

    /**
    * @Description Method to create user with minimal permissions
    **/
    private static User getContextUser() {
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