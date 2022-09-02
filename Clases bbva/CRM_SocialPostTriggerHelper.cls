/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_SocialPostTriggerHelper {

    /**
      * @description Groups all before insert validations
      * @param cases: List of Trigger.new cases
    */
    public static void beforeInsert(List<SocialPost> socialPosts){
        Boolean hasCustomPermission = FeatureManagement.checkPermission('CRM_SCC_Automate_Social_Post');
        if(!hasCustomPermission){
            handleFirstResponse(socialPosts);
        }
    }

    /**
      * @description Handles the first response when user send a social post
      * @param cases: List of Trigger.new social posts
    */
    public static void handleFirstResponse(List<SocialPost> socialPosts){
        DateTime completionDate = System.now();
        Map<Id, String> spIds = new Map<Id, String>();
        for (SocialPost sp : socialPosts){
            if(sp.IsOutbound) {
                spIds.put(sp.ParentId, sp.Id);
            }
        }

        if(!spIds.isEmpty()){
            Set<Id> spCaseIds = new Set<Id>();
            spCaseIds = spIds.keySet();
            List<Case> caseList = [
                SELECT Id, ContactId, SourceId, OwnerId,
                Status, EntitlementId, SlaStartDate, SlaExitDate
                FROM Case
                WHERE Id IN :spCaseIds WITH SECURITY_ENFORCED
            ];

            if(!caseList.isEmpty()){
                List<Case> casesToUpdate = getCasesToUpdate(caseList, spIds, completionDate);
                if(!casesToUpdate.isEmpty()) {
                    completeFirstContactMilestone(casesToUpdate, 'Primera respuesta al cliente', completionDate);
                }
            }
        }
    }

    /**
      * @description Filters the related case list
      * @param incomingCases: Related cases to email messages
      * @param spIds: Social post parent ids mapped with social child ids
      * @param completionDate: Given completion date for Case Milestone to compare
    */
    private static List<Case> getCasesToUpdate(List<Case> incomingCases, Map<Id, String> spIds, DateTime completionDate){
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
