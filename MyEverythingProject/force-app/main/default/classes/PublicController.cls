public class PublicController {
	public final Account acct {get; set;}
    public Attachment attachment {get;set;}
    
     public PageReference save(){

        if(acct.Name != null){
           insert acct;
        }

        return null;
    }
}