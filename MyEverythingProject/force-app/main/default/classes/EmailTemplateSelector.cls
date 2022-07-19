public class EmailTemplateSelector {
    
	public static EmailTemplate getEmailTemplate(string name){  
        return [Select Id,Name,Subject,HtmlValue,Body from EmailTemplate where name=:name LIMIT 1];
    }
    public static Account opportunityGetIdAccount(string idOpp){
        return [SELECT Name FROM Account WHERE Id =:idOpp LIMIT 1];
    }
    
    /* @invocableMethod
    public static List<string> opportunityGetIdOpportunity(List<string> getIdOpp){
        
        EmailTemplate coverTemplate = EmailTemplateSelector.getEmailTemplate('Envio de cotización');
        
        Account acc = [SELECT Name FROM Account WHERE Id =:getIdOpp LIMIT 1];
        Opportunity opp = [SELECT Id FROM Opportunity WHERE AccountId =:getIdOpp LIMIT 1];
        
        string htmlValue = coverTemplate.HtmlValue;
        htmlValue = htmlValue.replace('{!Opportunity.Account}', acc.Name);
        htmlValue = htmlValue.replace('{!Opportunity.Id}', opp.Id);
        
        String plainBody = coverTemplate.Body;
        plainBody = plainBody.replace('{!Opportunity.Account}', acc.Name);
        plainBody = plainBody.replace('{!Opportunity.Id}', opp.Id);
        
        List<String> listStrings = htmlValue.split(',');
        return ListStrings;
    } */
}