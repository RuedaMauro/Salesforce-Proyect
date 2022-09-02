public with sharing class LP_Cases extends fflib_SObjectDomain{
    private static List<Schema.SObjectType> SERVICE_SOBJECTS = new Schema.SObjectType[] { Case.SObjectType, CaseMilestone.SObjectType };
    public static List<Case> lstNewAux;
    
    public LP_Cases(List<Case> sObjectList) {
        super(sObjectList);
    }
    
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new LP_Cases(sObjectList);
        }
    }
    
    public override void onBeforeInsert() {
        list<Id> listAccountId = new list<Id>();
        list<Account> listAccounts = new list<Account>();

        map<String, LP_MilestoneTime__mdt> mapMilestoneTime = new LP_MilestoneTimeMDTSelector().selectAllMilestoneTime();
        BusinessHours bh = new LP_BusinessHoursSelector().selectActiveBusinessHours();
        map<String, RecordType> mapRecordTypes = new LP_CaseRecordTypeSelector().selectAllRecordCaseTypes();

        for (Case cas: (List<Case>) Trigger.new){
            if(mapMilestoneTime.containsKey(mapRecordTypes.get(cas.recordtypeId).Name.substringBefore(' ') + cas.type + cas.LP_Nivel1__c + cas.LP_Nivel2__c + cas.LP_Nivel3__c + (cas.LP_Ley20009__c == 'Sí'?'Sí':'No'))){
                LP_MilestoneTime__mdt obj = mapMilestoneTime.get(mapRecordTypes.get(cas.recordtypeId).Name.substringBefore(' ') + cas.type + cas.LP_Nivel1__c + cas.LP_Nivel2__c + cas.LP_Nivel3__c + (cas.LP_Ley20009__c == 'Sí'?'Sí':'No'));
                cas.LP_FechaDeCompromiso__c = BusinessHours.add(bh.Id, system.now(), 3600000 * Integer.valueOf(obj.LP_SLATotal__c));
            }
        }

        for(Case cas: (List<Case>) Records) {     

            if(cas.AccountId != null){
                listAccountId.add(cas.AccountId);
                listAccounts.add(new Account(Id = cas.AccountId));
            }
        }
        
        if(!listAccountId.isEmpty()){
            map<id,Entitlement> mapEntitlement = new map<id,Entitlement>();
            for(Entitlement item : new LP_EntitlementSelector().selectByAccountId(listAccountId)){
                mapEntitlement.put(item.AccountId, item);
            }
            
            if(mapEntitlement.isEmpty()){
                LP_Entitlements entitlements = new LP_Entitlements(new List<Entitlement>());
                entitlements.createEntitlements(listAccounts);

                mapEntitlement = new map<id,Entitlement>();
                for(Entitlement item : new LP_EntitlementSelector().selectByAccountId(listAccountId)){
                    mapEntitlement.put(item.AccountId, item);
                }
            }


            for(Case cas: (List<Case>) Records) {    
                if(mapEntitlement.containsKey(cas.AccountId)){
                    cas.EntitlementId = mapEntitlement.get(cas.AccountId).Id;
                }
            }
            lstNewAux =  (List<Case>) Records;
        }
    }
    
    public override void onAfterUpdate(Map<Id, SObject> sObjectMap) {
        Map<Id, Case> mapOld = (Map<Id, Case>)Trigger.oldMap;
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(SERVICE_SOBJECTS);
		LP_CaseMilestone.updateCaseMilestone(this, mapOld, uow);
    }
}