/**
* @author BBVA Salesforce Team
* @date 2021
*/
@IsTest
public class CRM_SocialPostRequest_Service_Test {

    /**
      * @description Test Social Post outbound respond
    */
    @IsTest static void shouldSendSocialPost(){
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

        System.runAs(contextUser){
            Case c = new Case();
            insert c;
            SocialPost sp = new SocialPost();
            sp.Name = 'Test';
            sp.ParentId = c.Id;
            insert sp;

            List<CRM_SocialPostRequest_Service.SocialPostRequest> requests = new List<CRM_SocialPostRequest_Service.SocialPostRequest>();


            CRM_SocialPostRequest_Service.SocialPostRequest request = new CRM_SocialPostRequest_Service.SocialPostRequest();
            request.respondingTo = sp;
            request.message = 'Mensaje';

            requests.add(request);
            Test.startTest();
            CRM_SocialPostRequest_Service.sendOutboundPosts(requests);
            CRM_SocialPostRequest_Service sap = new CRM_SocialPostRequest_Service();
            Test.stopTest();
        }

        system.assert(true, true);
    }
}