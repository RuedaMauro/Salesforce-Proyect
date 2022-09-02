/**
* @author BBVA Salesforce Team
* @date 2021
*/
public class CRM_EmailMessageTriggerHandler extends CRM_TriggerHandler{
    @TestVisible private List<EmailMessage> newEmailMessages;

    public CRM_EmailMessageTriggerHandler() {
        this.newEmailMessages = (List<EmailMessage>) Trigger.new;
    }

    /**
      * @description This method executes the before insert trigger event flow
    */
    public override void beforeInsert(){
        CRM_EmailMessageTriggerHelper.beforeInsert(newEmailMessages);
    }
}
