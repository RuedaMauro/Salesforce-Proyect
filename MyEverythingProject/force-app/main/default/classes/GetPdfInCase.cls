public class GetPdfInCase {
    
    @InvocableMethod
    public static void savePdf(List<String> idCase){
        
    		List<Case> casos = new List<Case>([SELECT Id,CaseNumber FROM Case WHERE Id =:idCase[0]]);

            PageReference ref = Page.SiteComunicaciones;
            ref.getParameters().put('id',casos[0].Id);
            Blob b = !Test.isRunningTest() ? ref.getContentAsPDF() : Blob.valueOf('Test content');
            
            DateTime dt = DateTime.now();
			String dateTimeStr = dt.format('hh:mm:ss');
            
            Attachment att = new Attachment();
            att.body = b;
            att.OwnerId = UserInfo.getUserId();
            att.ParentID = casos[0].ID;
            att.Name = 'Comunicación Generada ' + dateTimeStr + '.pdf' ;
            insert att;
    }

}