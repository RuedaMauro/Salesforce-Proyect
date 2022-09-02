public with sharing class CRM_CaseSelector {

    public List<Case> selectChildsByParentId(List<Id> recordId){
        List<Case> cases = new List<Case>();

        try {
            cases = [SELECT Id, CaseNumber, Status, CRM_AreaInterna__c, CreatedDate, toLabel(CRM_SCC_EntitlementStatus__c), CRM_SCC_LastComment__c, CRM_SCC_LastCommentDate__c FROM Case WHERE ParentId = :recordId WITH SECURITY_ENFORCED ORDER BY CreatedDate DESC]; //, CRM_SCC_LastComment, CRM_SCC_LastCommentDate
        } catch (Exception ex) {
            System.debug('Ex: ' + ex.getMessage());
        }

        return cases;
    }

    public List<Case> selectById(List<Id> recordId){
        List<Case> cases = new List<Case>();

        try {
            cases = [SELECT Id, CaseNumber, CreatedDate, CRM_SCC_ImportantCustomer__c, CRM_SCC_ImportantCustomerEmoji__c, CRM_SCC_ProductAndService__c, CRM_SCC_ContactReason__c, Status, CRM_AreaInterna__c, CRM_ClientFormula__c, CRM_SCC_LastComment__c, CRM_SCC_LastCommentDate__c FROM Case WHERE Id IN :recordId WITH SECURITY_ENFORCED];
        } catch (Exception ex) {
            System.debug('Ex: ' + ex.getMessage());
        }

        return cases;
    }

    public String getParentId(String recordId) {
        String parentId = '';

        try {
            List<Case> caseRecord = [SELECT Id, ParentId FROM Case WHERE Id = :recordId WITH SECURITY_ENFORCED];

            if(!caseRecord.isEmpty()){
                parentId = caseRecord.get(0).ParentId;
            }
            System.debug('Parentid: ' + parentId);
        } catch(DmlException dmlEx){
            System.debug('DML ex :: ' + dmlEx.getMessage());
        } catch (Exception e) {
            System.debug('Ex :: ' + e.getMessage());
        }

        return parentId;
    }
}