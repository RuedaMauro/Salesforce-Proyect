/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_SocialPostTriggerHandler extends CRM_TriggerHandler{
    @TestVisible private List<SocialPost> newSocialPosts;

    public CRM_SocialPostTriggerHandler() {
        this.newSocialPosts = (List<SocialPost>) Trigger.new;
    }

    /**
      * @description This method executes the before insert trigger event flow
    */
    public override void beforeInsert(){
        CRM_SocialPostTriggerHelper.beforeInsert(newSocialPosts);
    }
}
