/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class CRM_SCC_DNIRequest {
    @SuppressWarnings('sf:AvoidPublicFields')
    public class Request {
        @InvocableVariable (label='Social Post' required = true)
        public SocialPost socialPostRecord;
    }

    /**
      * @description This method updates Social Persona related record with the DNI setted as requested
      * @param data: Receives the current Social Post to find its related Social Persona
      * @return void
    */
    @InvocableMethod(label='Marcar DNI solicitado')
    public static void markDniAsRequested(List<Request> data){
      Set<Id> postIds = new Set<Id>();
        for (Request singleRequest: data) {
            postIds.add(singleRequest.socialPostRecord.Id);
        }

        List<SocialPost> posts = [SELECT Id, PersonaId FROM SocialPost WHERE Id IN :postIds WITH SECURITY_ENFORCED];
        Set<Id> personasIds = new Set<Id>();

        for(SocialPost post : posts){
            personasIds.add(post.PersonaId);
        }

        List<SocialPersona> personas = [SELECT Id, CRM_SCC_DNIRequested__c FROM SocialPersona WHERE Id IN :personasIds WITH SECURITY_ENFORCED];

        personas = setDniRequested(personas);
        update personas;
    }

    /**
      * @description This method sets DNI as requested for Social Persona related record
      * @param data: Receives the current Social Post to find its related Social Persona
      * @return List<SocialPersona>: The updated Social Persona list
    */
    private static List<SocialPersona> setDniRequested(List<SocialPersona> personasList) {
      for(SocialPersona singlePersona : personasList){
          singlePersona.CRM_SCC_DNIRequested__c = true;
      }

      return personasList;
  }
}
