/**
* @author BBVA Salesforce Team
* @date 2021
*/
public with sharing class ChangeUnlockTime {
    @SuppressWarnings('sf:AvoidPublicFields')
    public class Input {
        @InvocableVariable (label='Post Social' required = true)
        public SocialPost socialPostRecord;
    }
    /**
      * @description This method updates Social Persona related record with the new Unclok Time setted
      * @param data: Receives the current Social Post to find its related Social Persona
      * @return void
    */
    @InvocableMethod(label='Fijar hora de desbloqueo')
    public static void setUnlockTime(List<Input> data) {
        Set<Id> postIds = new Set<Id>();
        for (Input singleInput: data) {
            postIds.add(singleInput.socialPostRecord.Id);
        }

        List<SocialPost> posts = [SELECT Id, PersonaId FROM SocialPost WHERE Id IN :postIds WITH SECURITY_ENFORCED];
        Set<Id> personasIds = new Set<Id>();

        for(SocialPost post : posts){
            personasIds.add(post.PersonaId);
        }

        List<SocialPersona> personas = [SELECT Id, UnlockTime__c FROM SocialPersona WHERE Id IN :personasIds WITH SECURITY_ENFORCED];

        personas = setUnlockTimeInPersona(personas);
        update personas;
    }
    /**
      * @description This method sets a new Unlock Time for Social Persona related record
      * @param data: Receives the current Social Post to find its related Social Persona
      * @return List<SocialPersona>: The updated Social Persona list
    */
    private static List<SocialPersona> setUnlockTimeInPersona(List<SocialPersona> personasList) {
        PauseDuration__mdt pd = [SELECT PauseValue__c FROM PauseDuration__mdt WHERE Developername = 'AutoRespondPause' WITH SECURITY_ENFORCED];
        for(SocialPersona singlePersona : personasList){
            Datetime givenDateTime = System.now();
            singlePersona.UnlockTime__c = givenDateTime.addMinutes(Integer.valueOf(pd.PauseValue__c));
        }

        return personasList;
    }
}