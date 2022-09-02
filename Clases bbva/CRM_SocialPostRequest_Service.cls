/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_SocialPostRequest_Service {
    /**
      * @description This method handles the Social Post list with messages when method is invoked
      * @param posts: Receives the given Social Post and the desired message
      * @return void
    */
    @InvocableMethod(label='Respuesta Automática Social Service' description='Envía una respuesta automática a las redes sociales')
    public static void sendOutboundPosts(List<SocialPostRequest> posts) {
        for (SocialPostRequest post : posts) {
            sendOutboundPost(post);
        }
    }
    /**
      * @description This method sends the response to the Social Media
      * @param posts: A single Social Post request
      * @return void
    */
    public static void sendOutboundPost(SocialPostRequest data) {
        SocialPost outboundPost = new SocialPost();
        outboundPost.content = data.message;

        QuickAction.QuickActionRequest req = new QuickAction.QuickActionRequest();
            req.quickActionName = Schema.Case.QuickAction.SocialPublisher;
            req.record = outboundPost;
            req.contextId = data.respondingTo.ParentId;

        if(!Test.isRunningTest()){
            QuickAction.QuickActionResult res = QuickAction.performQuickAction(req);
        }
    }
    @SuppressWarnings('sf:AvoidPublicFields')
    public class SocialPostRequest {

        @InvocableVariable(required=true)
        public SocialPost respondingTo;

        @InvocableVariable(required=true)
        public String message;
    }
}