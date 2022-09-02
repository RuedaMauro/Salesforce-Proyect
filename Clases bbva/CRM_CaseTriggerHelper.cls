/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_CaseTriggerHelper {

    /**
      * @description Groups all before insert validations
      * @param cases: List of Trigger.new cases
    */
    public static void beforeInsert(List<Case> cases){
        assignEntitlements(cases, 'SocialCustomerCare', 'CRM_Cas_ParentCase');
        assignChildCaseEntitlements(cases, 'CRM_Cas_ChildCase');
    }

    /**
      * @description Groups all after insert validations
      * @param cases: List of Trigger.new cases
    */
    public static void afterInsert(List<Case> cases){
        activateAssignmentRules(cases);
    }

    /**
      * @description Assign given entitlement to the specified recordtypes for cases
      * @param cases: List of Trigger.new cases
    */
    public static void assignEntitlements(List<Case> cases, String entitlementName, String recordTypeName){
        List<Entitlement> entitlementToAdd = [SELECT Id FROM Entitlement WHERE Name = :entitlementName WITH SECURITY_ENFORCED LIMIT 1];
        List<RecordType> caseRT = [SELECT Id FROM RecordType WHERE DeveloperName = :recordTypeName WITH SECURITY_ENFORCED LIMIT 1];
        if(!entitlementToAdd.isEmpty() && !caseRT.isEmpty()){
            for(Case c : cases){
                if(c.RecordTypeId == caseRT.get(0).Id){
                    c.EntitlementId = entitlementToAdd.get(0).Id;
                }
            }
        }
    }

    /**
      * Juntar en una lista todos los CRM_Management de todos los casos
      * Consultar los entitlement name que coincidan con la lista de CRM_Management
      * Mapear casos hijos con su respectivo management
      */
    public static void assignChildCaseEntitlements(List<Case> cases, String recordTypeName){
        Set<String> entitlementNames = new Set<String>();
        Map<Id, String> entitlementNamesByCaseId = new Map<Id, String>();

        for(Case singleCase : cases){
            String management = singleCase.CRM_SCC_Management__c;
            entitlementNames.add(management);
            entitlementNamesByCaseId.put(singleCase.Id, management);
        }

        List<Entitlement> entitlementsToAdd = [SELECT Id, Name FROM Entitlement WHERE Name IN :entitlementNames WITH SECURITY_ENFORCED];
        List<RecordType> caseRT = [SELECT Id FROM RecordType WHERE DeveloperName = :recordTypeName WITH SECURITY_ENFORCED LIMIT 1];

        if(!entitlementsToAdd.isEmpty() && !caseRT.isEmpty()){
            Map<String, Id> entitlementIdsByName = new Map<String, Id>();

            for (Entitlement singleEntitlement : entitlementsToAdd) {
                if(!entitlementIdsByName.containsKey(singleEntitlement.Name)){
                    entitlementIdsByName.put(singleEntitlement.Name, singleEntitlement.Id);
                }
            }

            for (Case singleCase : cases) {
                String entitlementName = entitlementNamesByCaseId.get(singleCase.Id);
                if(singleCase.RecordTypeId == caseRT.get(0).Id){
                    singleCase.EntitlementId = entitlementIdsByName.get(entitlementName);
                }
            }
        }
    }

    /**
      * @description Activate assignment rules for given case recordtypes
      * @param cases: List of Trigger.new cases
    */
    public static void activateAssignmentRules(List<Case> cases){
        List<AssignmentRule> ar = [SELECT Id FROM AssignmentRule WHERE (SobjectType = 'Case' AND Active = true AND Name = 'Social - Asignación de Casos') WITH SECURITY_ENFORCED LIMIT 1];
        Map<Id, RecordType> validRecordTypes = new Map<Id, RecordType>([SELECT Id FROM RecordType WHERE DeveloperName IN ('CRM_Cas_ChildCase', 'CRM_Cas_ParentCase') WITH SECURITY_ENFORCED]);

        List<Case> casesToUpdate = new List<Case>();

        if(!ar.isEmpty() && !validRecordTypes.isEmpty()){
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.assignmentRuleId = ar.get(0).id;

            Set<Id> caseIds = new Set<Id>();

            for(Case c : cases){
                if(validRecordTypes.containsKey(c.RecordTypeId)){
                    caseIds.add(c.Id);
                }
            }

            for(Case c : [SELECT Id FROM Case WHERE Id in :caseIds WITH SECURITY_ENFORCED]){
                c.setOptions(dmlOpts);
                casesToUpdate.add(c);
            }

            update casesToUpdate;
        }
    }
}