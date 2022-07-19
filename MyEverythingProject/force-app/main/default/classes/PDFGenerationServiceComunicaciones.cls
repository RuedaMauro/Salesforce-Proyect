public class PDFGenerationServiceComunicaciones {
    
    @InvocableMethod
    public static void sendOpportunity(list<String> recordEmail)
    {       
        EmailTemplate coverTemplate = EmailTemplateSelector.getEmailTemplate('Comunicación: Notificación de respuesta final al reportante');
        EmailTemplate attachTemplate = EmailTemplateSelector.getEmailTemplate('Prueba pdfv5');
        
        System.debug(coverTemplate);
        
        if(attachTemplate!=null && coverTemplate!=null)
        {            
            List<Case> casos = new List<Case>([SELECT Id,Fecha_de_recepcion_de_caso__c,CaseNumber,SuppliedEmail,Subject FROM Case WHERE Id =:recordEmail[0]]);
            //List<Account> acc = new List<Account>([SELECT Name FROM Account WHERE Id =: opp[0].AccountId LIMIT 1]);
            //List<OpportunityLineItem> oppItem = new List<OpportunityLineItem>([SELECT Name,Product2Id,ProductCode, Quantity FROM OpportunityLineItem WHERE OpportunityId =:opp[0].id]);

            string htmlValue = coverTemplate.Body;

            htmlValue = htmlValue.replace('{!Case.Fecha_de_recepcion_de_caso__c}', string.valueOfGmt(casos[0].Fecha_de_recepcion_de_caso__c));
            htmlValue = htmlValue.replace('{!Case.CaseNumber}', casos[0].CaseNumber);            
            
            PageReference ref = Page.SiteComunicaciones;
            ref.getParameters().put('id',casos[0].Id);
            Blob b = !Test.isRunningTest() ? ref.getContentAsPDF() : Blob.valueOf('Test content');
            
            Map<String, String> ncParams=new Map<String, String> {'{name}' => ''};
            Messaging.EmailFileAttachment attach = EmailHelper.attachementBuilder('Comunicación.pdf',b);
            Messaging.SingleEmailMessage mail=EmailHelper.emailBuilder(casos[0].SuppliedEmail,casos[0].Subject,htmlValue,ncParams);      
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach}); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            DateTime dt = DateTime.now();
			String dateTimeStr = dt.format('hh:mm:ss');
            
            Attachment att = new Attachment();
            att.body = b;
            att.OwnerId = UserInfo.getUserId();
            att.ParentID = casos[0].ID;
            att.Name = 'Comunicación Enviada al mail ' + dateTimeStr + '.pdf' ;
            insert att;
            
        }
    }

}