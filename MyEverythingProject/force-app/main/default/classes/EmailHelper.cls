public class EmailHelper {
	private static String setBodyValues(string body,Map<String,String> params){
        if(params!=null && params.size()>0){
            for(String key :params.keySet()){
                string val=params.get(key);
                body=body.replace(key,val);
                system.debug('body:'+body);
            }
        }
        return body;
    }
    
    public static List<Opportunity> getIdOpportunity(List<String> getIdOpp){
        List<Opportunity> opp = new List<Opportunity>([SELECT Id FROM Opportunity WHERE AccountId =:getIdOpp LIMIT 1]);
    	return opp;
    }
    
    
    public static Messaging.EmailFileAttachment attachementBuilder(string fileName,Blob emailHtml)
    {
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName(fileName);
        attach.setInline(true);
       // String body=emailHtml;
        //body=setBodyValues(body,emailContent);
        attach.Body = emailHtml;
        return attach;
    }
    
    public static Messaging.SingleEmailMessage emailBuilder(String email,string subject,string emailHtml,Map<String,String> emailContent)
    { 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        //mail.setWhatId('0010200000FBWUjAAP'); // registro relacionado
       // mail.setTargetObjectId(); // objeto
        mail.setToAddresses(new string[]{email});
        mail.setSubject(subject);
       	String body=emailHtml; 
       	body=setBodyValues(body,emailContent);
        mail.setHtmlBody(body);
        return mail;
    }
}