/**
* @author BBVA Salesforce Team
* @date 2021
*/
@IsTest
public class ChangeUnlockTime_Test {

    @isTest static void shouldSetNewUnlockTime() {
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

        System.debug('Context user:' + contextUser);

        System.runAs(contextUser){
            Account acc = new Account(Name = 'Test Account');
            insert acc;

            SocialPersona spersona = new SocialPersona(
                Name = 'Social Person Test',
                ParentId = acc.Id,
                Provider = 'Facebook'
            );
            insert spersona;

            SocialPost sp = new SocialPost(name='Social Post Test', PersonaId = spersona.Id, IsOutbound=true);
            insert sp;

            Test.startTest();
            ChangeUnlockTime.Input input = new ChangeUnlockTime.Input();
            input.socialPostRecord = sp;
            ChangeUnlockTime.setUnlockTime(new List<ChangeUnlockTime.Input>{input});
            spersona = [SELECT Id, UnlockTime__c FROM SocialPersona WHERE Id = :spersona.Id];
            Test.stopTest();
            System.assertEquals(true, (spersona.UnlockTime__c > System.now()), 'The new unlock time should be greater than the current time');
        }

    }
}