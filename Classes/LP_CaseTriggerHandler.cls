public with sharing class LP_CaseTriggerHandler extends TriggerHandler{
    private Map<Id, Case> newOppMap;
    private LP_Cases sObjectDomain;
    
    public LP_CaseTriggerHandler() {
        this.newOppMap = (Map<Id, Case>) Trigger.newMap;
        this.sObjectDomain = new LP_Cases(records);
    }
    
    public override void beforeInsert() {
        sObjectDomain.onBeforeInsert();
    }
    
    public override void afterUpdate() {
        sObjectDomain.onAfterUpdate((Map<Id, Case>)Trigger.newMap);
    }
}