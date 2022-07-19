public class PDFGenerationService {
    @InvocableMethod
    public static void sendOpportunity(list<String> recordEmail)
    {       
        EmailTemplate coverTemplate = EmailTemplateSelector.getEmailTemplate('Template Envio Presupuesto');
        EmailTemplate attachTemplate = EmailTemplateSelector.getEmailTemplate('Prueba pdfv5');
        System.debug(coverTemplate);
        
        if(attachTemplate!=null && coverTemplate!=null)
        {            
            List<Opportunity> opp = new List<Opportunity>([SELECT Id,Numero_ID_solicitante__c,Tipo_ID_Solicitante__c,Correo_electronico_solicitante__c,AccountId,Amount, Consecutivo_presupuesto__c FROM Opportunity WHERE Id =:recordEmail[0]]);
            List<Account> acc = new List<Account>([SELECT Name FROM Account WHERE Id =: opp[0].AccountId LIMIT 1]);
            List<OpportunityLineItem> oppItem = new List<OpportunityLineItem>([SELECT Name,Product2Id,ProductCode, Quantity FROM OpportunityLineItem WHERE OpportunityId =:opp[0].id]);
            
            System.debug('Lista opp --> ' + opp);
            System.debug('Lista acc --> ' + acc);
            System.debug('Lista oppItem --> ' + oppItem);
            string htmlValue = coverTemplate.HtmlValue;
            System.debug('htmlValue -->' + htmlValue);
            string htmlValue2 = attachTemplate.HtmlValue;
            
            htmlValue = htmlValue.replace('{!Opportunity.Account}', acc[0].Name);
            htmlValue = htmlValue.replace('{!Opportunity.Consecutivo_presupuesto__c}', opp[0].Consecutivo_presupuesto__c);            
            htmlValue = htmlValue.replace('{!Opportunity.Tipo_ID_Solicitante__c}', opp[0].Tipo_ID_Solicitante__c);
            htmlValue = htmlValue.replace('{!Opportunity.Numero_ID_solicitante__c}', opp[0].Numero_ID_solicitante__c);
            
            
            
            string aux2 = String.valueOf(oppItem[0].Quantity);
            
            htmlValue2 = htmlValue2.replace('{!Opportunity.Account}', acc[0].Name);
            htmlValue2 = htmlValue2.replace('{!Opportunity.Tipo_ID_Solicitante__c}', opp[0].Tipo_ID_Solicitante__c);
            htmlValue2 = htmlValue2.replace('{!Opportunity.Numero_ID_solicitante__c}', opp[0].Numero_ID_solicitante__c);
            string aux = String.valueOf(opp[0].Amount);
            htmlValue2 = htmlValue2.replace('{!Opportunity.Amount}', aux);
            
            List<String> ListProducts = new List<String>();
            
            htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.ProductCode}', oppItem[0].ProductCode);
            htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Name}', oppItem[0].Name);
            htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Quantity}', aux2);
            
            
            //htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.ProductCode}', oppItem[0].ProductCode);
            //htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Name}', oppItem[0].Name);
            //htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Quantity}', aux2);
            
            // String plainBody = coverTemplate.Body;
            // plainBody = plainBody.replace('{!Opportunity.Account}', acc[0].Name);
            // plainBody = plainBody.replace('{!Opportunity.Consecutivo_presupuesto__c}', opp[0].Consecutivo_presupuesto__c);
            
            PageReference ref = Page.templatePresupuestos;
            ref.getParameters().put('id',opp[0].Id);
            Blob b = !Test.isRunningTest() ? ref.getContentAsPDF() : Blob.valueOf('Test content');
            
            Map<String, String> ncParams=new Map<String, String> {'{name}' => ''};
            Messaging.EmailFileAttachment attach = EmailHelper.attachementBuilder('Presupuesto.pdf',b);
            Messaging.SingleEmailMessage mail=EmailHelper.emailBuilder(opp[0].Correo_electronico_solicitante__c,opp[0].Consecutivo_presupuesto__c,htmlValue,ncParams);      
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach}); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            DateTime dt = DateTime.now();
			String dateTimeStr = dt.format('hh:mm:ss');
            
            Attachment att = new Attachment();
            att.body = b;
            att.OwnerId = UserInfo.getUserId();
            att.ParentID = opp[0].ID;
            att.Name = 'Presupuesto Enviado al mail ' + dateTimeStr + '.pdf' ;
            insert att;
            
        }
    }
    
}