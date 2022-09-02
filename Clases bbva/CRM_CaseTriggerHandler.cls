/**
* @author BBVA Salesforce Team
* @date 2021
*/
public class CRM_CaseTriggerHandler extends CRM_TriggerHandler{
    @TestVisible private List<Case> newCases;

    public CRM_CaseTriggerHandler() {
        this.newCases = (List<Case>) Trigger.new;
    }

    /**
      * @description This method executes the before insert trigger event flow
    */
    public override void beforeInsert(){
        CRM_CaseTriggerHelper.beforeInsert(newCases);
    }

    /**
      * @description This method executes the after insert trigger event flow
    */
    public override void afterInsert(){
        CRM_CaseTriggerHelper.afterInsert(newCases);
    }
}
