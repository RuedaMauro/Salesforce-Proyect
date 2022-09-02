/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_SCC_MilestoneCompletionSocial {

    @SuppressWarnings('sf:AvoidPublicFields')
    public class Request {

        @InvocableVariable(required=true)
        public Id sourceCase;

        @InvocableVariable(required=true)
        public String milestoneName;
    }

    /**
      * @description Filters the related case list
      * @param incomingCases: Related cases to milestone
      * @param completionDate: Given completion date for Case Milestone to compare
    */
    @InvocableMethod(label='Completar milestones' description='Completa el milestone dado para la lista de casos relacionados')
    public static void milestoneCompletion(List<Request> requests) {
        List<Id> caseIds = new List<Id>();
        String milestoneName = requests.get(0).milestoneName;

        for (Request singleReq : requests) {
            caseIds.add(singleReq.sourceCase);
        }

        List<Case> incomingCases = [SELECT Id, EntitlementId, SlaStartDate, SlaExitDate FROM Case WHERE Id IN :caseIds WITH SECURITY_ENFORCED];

        DateTime completionDate = System.now();
        List<Case> casesToUpdate = getCasesToUpdate(incomingCases, completionDate);

        if(!casesToUpdate.isEmpty()){
            completeMilestone(casesToUpdate, milestoneName, completionDate);
        }


    }

    /**
      * @description Filters the related case list
      * @param incomingCases: Related cases to milestone
      * @param completionDate: Given completion date for Case Milestone to compare
    */
    private static List<Case> getCasesToUpdate(List<Case> incomingCases, DateTime completionDate){
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
      * @param relatedCases: Related to milestone cases
      * @param milestoneName: Case Milestone name to query
      * @param completionDate: Given date for Case Milestone completion
    */
    private static void completeMilestone(List<Case> relatedCases, String milestoneName, DateTime completionDate){
        List<CaseMilestone> toUpdate = [
            SELECT Id, CompletionDate
            FROM CaseMilestone cm
            WHERE CaseId IN :relatedCases AND cm.MilestoneType.Name = :milestoneName AND CompletionDate = null AND IsCompleted = false WITH SECURITY_ENFORCED
        ];
        if(!toUpdate.isEmpty()){
            for (CaseMilestone cm : toUpdate){
                cm.CompletionDate = completionDate;
            }
            update toUpdate;
        }
    }
}