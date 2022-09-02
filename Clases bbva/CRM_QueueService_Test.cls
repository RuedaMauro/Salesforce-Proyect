/**
  * -------------------------------------------------------------------------------------------------
  * @Name   CRM_QueueService_Test
  * @Author Luciano Ditzel lucianoagustin.ditzelramirez.contractor@gdevtools.com
  * @Date   Created: 2022-01-10
  * -------------------------------------------------------------------------------------------------
  * @Description This public class tests the CRM_QueueService class
  * -------------------------------------------------------------------------------------------------
  * @Changes
  *
  **/
@IsTest
public class CRM_QueueService_Test {

    /**
      * @Description Test data setup
      **/
    @TestSetup
    static void makeData(){
        User contextUser = getContextUser();
        Group g1 = new Group(Name='Social Queue Test', DeveloperName='CRM_SCC_Cas_Soc_Test', Type='Queue');
        insert g1;
        QueuesObject q1 = new QueueSObject(QueueId = g1.id, SobjectType = 'Case');
        insert q1;

        GroupMember member = new GroupMember();
        member.UserOrGroupId = contextUser.Id;
        member.GroupId = g1.Id;
        insert member;
    }

    /**
      * @Description Test method for social queue retrieve
      **/
    @IsTest()
    static void getSocialQueuesTest(){
        User contextUser = [SELECT Id FROM User WHERE Username='test-user@bbva.com.ar'];

        Test.startTest();
        System.runAs(contextUser){
            List<CRM_QueueService.QueueElement> queues = CRM_QueueService.getSocialQueues();
            System.assertNotEquals(null, queues, 'Should retrieve all social queues');
        }
        Test.stopTest();

    }

    /**
      * @Description Test method for queue assignments
      **/
    @IsTest()
    static void changeQueueAssignmentTest(){
        User contextUser = [SELECT Id FROM User WHERE Username='test-user@bbva.com.ar'];
        List<Group> queues = [SELECT Id, Name, DeveloperName, Type, (SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Type = 'Queue' AND DeveloperName LIKE 'CRM_SCC_Cas_Soc%' WITH SECURITY_ENFORCED LIMIT :Limits.getLimitQueryRows()];

        Test.startTest();
        System.runAs(contextUser){
            CRM_QueueService.Response response = CRM_QueueService.changeQueueAssignment(new List<Id>{queues.get(0).Id}, new List<Id>{queues.get(1).Id});
            System.assertNotEquals(null, response, 'Should recieve a response');
        }
        Test.stopTest();

    }


    /**
      * @Description Context user helper method
      **/
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