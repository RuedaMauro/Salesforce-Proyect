public with sharing class CRM_CaseLinkerController {
  /* Controller */
  @AuraEnabled
  public static void linkCases(String casesToLink, Id caseId) {
    RelatedCase relatedCases = (RelatedCase) JSON.deserialize(
      casesToLink,
      RelatedCase.class
    );
    try {
      if (casesToLink != null) {
        List<CaseRelationship__c> relationships = new List<CaseRelationship__c>();
        for (CaseItem relatedCase : relatedCases.notLinkedCases) {
          CaseRelationship__c relationship = new CaseRelationship__c();

          relationship.MasterCase__c = caseId;
          relationship.SlaveCase__c = relatedCase.caseId;

          relationships.add(relationship);
        }

        insert relationships;
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage()); //NOSONAR
    }
  }

  @AuraEnabled(cacheable=true)
  public static RelatedCase getRelatedCases(Id caseId) {
    RelatedCase response = new RelatedCase();
    response.notLinkedCases = new List<CaseItem>();
    try {
      Case currentCase = selectCaseById(caseId);
      Map<Id, Case> casesById = selectCasesByAccount(currentCase.AccountId); //Remove current case from list
      List<CaseRelationship__c> relationships = selectCaseRelationshipByMasterCaseId(
        caseId
      );

      // Remove original case from list
      casesById.remove(caseId);

      // Remove already related records from list
      for (CaseRelationship__c relationship : relationships) {
        if (casesById.containsKey(relationship.SlaveCase__c)) {
          casesById.remove(relationship.SlaveCase__c);
        }

        if (casesById.containsKey(relationship.MasterCase__c)) {
          casesById.remove(relationship.MasterCase__c);
        }
      }

      // Add not related cases to list
      for (Case caseRecord : casesById.values()) {
        CaseItem item = new CaseItem();
        item.caseId = caseRecord.Id;
        item.caseNumber = caseRecord.CaseNumber;
        item.subject = caseRecord.Subject;
        item.createdDate = caseRecord.CreatedDate;
        item.contactName = caseRecord.Contact.Name;

        response.notLinkedCases.add(item);
      }
    } catch (Exception e) {
      throw new AuraHandledException(e.getMessage()); //NOSONAR
    }

    return response;
  }

  /* Selectors */
  private static Case selectCaseById(Id caseId) {
    return [
      SELECT Id, AccountId
      FROM Case
      WHERE Id = :caseId
      WITH SECURITY_ENFORCED
    ];
  }

  private static Map<Id, Case> selectCasesByAccount(Id accountId) {
    return new Map<Id, Case>(
      [
        SELECT Id, CaseNumber, Subject, CreatedDate, Contact.Name
        FROM Case
        WHERE AccountId = :accountId
        WITH SECURITY_ENFORCED
      ]
    );
  }

  private static List<CaseRelationship__c> selectCaseRelationshipByMasterCaseId(
    Id caseId
  ) {
    return [
      SELECT Id, MasterCase__c, SlaveCase__c
      FROM CaseRelationship__c
      WHERE MasterCase__c = :caseId OR SlaveCase__c = :caseId
      WITH SECURITY_ENFORCED
    ];
  }

  /* Dtos */

  public class RelatedCase {
    @AuraEnabled
    public List<CaseItem> notLinkedCases { get; set; }
  }

  public class CaseItem {
    @AuraEnabled
    public String caseNumber { get; set; }
    @AuraEnabled
    public String caseId { get; set; }
    @AuraEnabled
    public String subject { get; set; }
    @AuraEnabled
    public Datetime createdDate { get; set; }
    @AuraEnabled
    public String contactName { get; set; }
  }
}
