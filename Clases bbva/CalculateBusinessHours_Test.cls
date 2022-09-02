/**
* @author BBVA Salesforce Team
* @date 2021
*/
@IsTest
public class CalculateBusinessHours_Test {
    @isTest static void checkDateInsideBusinessHours() {
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

        List<CalculateBusinessHours.Request> inputparams = new List<CalculateBusinessHours.Request>();
        CalculateBusinessHours.Request pf = new CalculateBusinessHours.Request();
        pf.givenDateTime = Datetime.newInstance(2021,11,30,11,0,0);
        pf.businessHoursName = 'Default';
        inputparams.add(pf);
        System.runAs(contextUser){
            Test.startTest();
            List<CalculateBusinessHours.Response> response = CalculateBusinessHours.isWithinBusinessHours(inputParams);
            Test.stopTest();
            System.assertEquals(true, response[0].isWithinBusinessHours, 'Should be within the business hour');
        }
    }
}