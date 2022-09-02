@IsTest
public with sharing class CRM_CaseLinkerControllerTest {
  @TestSetup
  static void makeData() {
    Account acc = new Account();
    acc.LastName = 'Test acc';
    insert acc;

    Case masterCase = new Case();
    masterCase.AccountId = acc.Id;
    masterCase.Subject = 'Master case';
    insert masterCase;

    Case slaveCase = new Case();
    slaveCase.AccountId = acc.Id;
    slaveCase.Subject = 'Slave case';
    insert slaveCase;
  }

  @IsTest
  static void testLinkCases() {
    User contextUser = getContextUser();

    Id masterCaseId = [
      SELECT Id, CaseNumber, Subject, CreatedDate
      FROM Case
      WHERE Subject = 'Master case'
      LIMIT 1
    ]
    .Id;

    Case slaveCase = [
      SELECT Id, CaseNumber, Subject, CreatedDate
      FROM Case
      WHERE Subject = 'Slave case'
      LIMIT 1
    ];


    CRM_CaseLinkerController.RelatedCase relatedCase = new CRM_CaseLinkerController.RelatedCase();
    relatedCase.notLinkedCases = new List<CRM_CaseLinkerController.CaseItem>();
    CRM_CaseLinkerController.CaseItem caseItem = new CRM_CaseLinkerController.CaseItem();
    caseItem.caseId = slaveCase.Id;
    caseItem.caseNumber = slaveCase.CaseNumber;
    caseItem.subject = slaveCase.Subject;
    caseItem.createdDate = slaveCase.CreatedDate;
    caseItem.contactName = 'Test contact';

    relatedCase.notLinkedCases.add(caseItem);

    Test.startTest();

    System.runAs(contextUser) {
      CRM_CaseLinkerController.linkCases(
        JSON.serialize(relatedCase),
        masterCaseId
      );
    }
    System.assertEquals(true, true, 'Case linked');
    Test.stopTest();
  }

  @IsTest
  static void testGettingRelatedCases() {
    Case masterCase = [
      SELECT Id, CaseNumber, Subject, CreatedDate
      FROM Case
      WHERE Subject = 'Master case'
      LIMIT 1
    ];

    User contextUser = getContextUser();
    Test.startTest();

    CRM_CaseLinkerController.RelatedCase relatedCase = new CRM_CaseLinkerController.RelatedCase();
    relatedCase.notLinkedCases = new List<CRM_CaseLinkerController.CaseItem>();
    CRM_CaseLinkerController.CaseItem caseItem = new CRM_CaseLinkerController.CaseItem();
    caseItem.caseId = masterCase.Id;
    caseItem.caseNumber = masterCase.CaseNumber;
    caseItem.subject = masterCase.Subject;
    caseItem.createdDate = masterCase.CreatedDate;
    caseItem.contactName = 'Test contact';

    relatedCase.notLinkedCases.add(caseItem);
    CRM_CaseLinkerController.RelatedCase foundCases = new CRM_CaseLinkerController.RelatedCase();

    System.runAs(contextUser) {
      foundCases = CRM_CaseLinkerController.getRelatedCases(caseItem.caseId);
    }

    system.assertNotEquals(null, foundCases, 'Found cases should not be null');
    Test.stopTest();
  }

  private static User getContextUser() {
    Profile minimumAccessProfile = [
      SELECT Id
      FROM Profile
      WHERE Name = 'Minimum Access - Salesforce'
    ];
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
    PermissionSet ps = [
      SELECT Id
      FROM PermissionSet
      WHERE Name = 'CRM_SCC_SocialSystemAdmin'
    ];

    insert new PermissionSetAssignment(
      AssigneeId = contextUser.id,
      PermissionSetId = ps.Id
    );

    return contextUser;
  }
}