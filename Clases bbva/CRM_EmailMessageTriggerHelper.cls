/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_EmailMessageTriggerHelper {

    /**
      * @description Groups all before insert validations
      * @param cases: List of Trigger.new cases
    */
    public static void beforeInsert(List<EmailMessage> emailMessages){
        handleFirstResponse(emailMessages);
    }

    /**
      * @description Handles the first response when user send an email
      * @param cases: List of Trigger.new email messages
    */
    public static void handleFirstResponse(List<EmailMessage> emailMessages){
        DateTime completionDate = System.now();
        Map<Id, String> emIds = new Map<Id, String>();
        for (EmailMessage em : emailMessages){
            if(em.Incoming == false) {
                emIds.put(em.ParentId, em.ToAddress);
            }
        }

        if(emIds.isEmpty() == false){
            Set<Id> emCaseIds = new Set<Id>();
            emCaseIds = emIds.keySet();
            List<Case> caseList = [
                SELECT Id, ContactId, Contact.Email, OwnerId,
                Status, EntitlementId, SlaStartDate, SlaExitDate
                FROM Case
                WHERE Id IN :emCaseIds WITH SECURITY_ENFORCED
            ];

            if(!caseList.isEmpty()){
                List<Case> casesToUpdate = getCasesToUpdate(caseList, emIds, completionDate);
                if(!casesToUpdate.isEmpty()) {
                    completeFirstContactMilestone(casesToUpdate, 'Primera respuesta al cliente', completionDate);
                }
            }
        }
    }

    /**
      * @description Filters the related case list
      * @param incomingCases: Related cases to email messages
      * @param emIds: Email message parent ids mapped with email address
      * @param completionDate: Given completion date for Case Milestone to compare
    */
    private static List<Case> getCasesToUpdate(List<Case> incomingCases, Map<Id, String> emIds, DateTime completionDate){
        List<Case> casesToUpdate = new List<Case>();

        for (Case caseObj : incomingCases) {
            Boolean isMilestoneAvailable = (caseObj.EntitlementId != null) && (caseObj.SlaStartDate <= completionDate) && (caseObj.SlaStartDate != null) && (caseObj.SlaExitDate == null);
            if (isMilestoneAvailable) {
                casesToUpdate.add(caseObj);
            }
        }

        return casesToUpdate;
    }

    /**
      * @description Update Case Milestones with correspond completion date
      * @param caseIds: Related cases ids
      * @param milestoneName: Case Milestone name to query
      * @param completionDate: Given date for Case Milestone completion
    */
    private static void completeFirstContactMilestone(List<Case> caseIds, String milestoneName, DateTime completionDate){
        List<CaseMilestone> toUpdate = [
            SELECT Id, CompletionDate
            FROM CaseMilestone cm
            WHERE CaseId IN :caseIds AND cm.MilestoneType.Name = :milestoneName AND CompletionDate = null AND IsCompleted = false WITH SECURITY_ENFORCED LIMIT 1
        ];
        if(!toUpdate.isEmpty()){
            for (CaseMilestone cm : toUpdate){
                cm.CompletionDate = completionDate;
            }
            update toUpdate;
        }
    }
}
