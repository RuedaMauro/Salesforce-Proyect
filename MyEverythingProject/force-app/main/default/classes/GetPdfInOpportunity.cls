public class GetPdfInOpportunity {
    @InvocableMethod
    public static void savePdf(List<String> idOpportunity){
        
        List<Opportunity> opp = new List<Opportunity>([SELECT Id,Numero_ID_solicitante__c,Tipo_ID_Solicitante__c,Correo_electronico_solicitante__c,AccountId,Amount, Consecutivo_presupuesto__c FROM Opportunity Where ID=:idOpportunity]);
        List<Account> acc = new List<Account>([SELECT Name FROM Account WHERE Id =: opp[0].AccountId LIMIT 1]);
        List<OpportunityLineItem> oppItem = new List<OpportunityLineItem>([SELECT Name,Product2Id,ProductCode, Quantity FROM OpportunityLineItem WHERE OpportunityId =:opp[0].id]);
        
        EmailTemplate attachTemplate = EmailTemplateSelector.getEmailTemplate('Prueba pdfv5');
        string htmlValue2 = attachTemplate.HtmlValue;
        
        string aux2 = String.valueOf(oppItem[0].Quantity);
        htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Quantity}', aux2);
        htmlValue2 = htmlValue2.replace('{!Opportunity.Account}', acc[0].Name);
        htmlValue2 = htmlValue2.replace('{!Opportunity.Tipo_ID_Solicitante__c}', opp[0].Tipo_ID_Solicitante__c);
        htmlValue2 = htmlValue2.replace('{!Opportunity.Numero_ID_solicitante__c}', opp[0].Numero_ID_solicitante__c);
        string aux = String.valueOf(opp[0].Amount);
        htmlValue2 = htmlValue2.replace('{!Opportunity.Amount}', aux);
        htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.ProductCode}', oppItem[0].ProductCode);
        htmlValue2 = htmlValue2.replace('{!OpportunityLineItem.Name}', oppItem[0].Name);
        
        Attachment att = new Attachment();
        /*att.body = Blob.toPDF(htmlValue2);
        att.ParentID = acc[0].ID;
        att.Name = 'Presupuesto.pdf'; 
        */
        
        DateTime dt = DateTime.now();
		String dateTimeStr = dt.format('hh:mm:ss');

        
        PageReference ref = Page.templatePresupuestos;
        ref.getParameters().put('id',opp[0].Id);
        Blob b = !Test.isRunningTest() ? ref.getContentAsPDF() : Blob.valueOf('Test content');
        att.body = b;
        att.OwnerId = UserInfo.getUserId();
        att.ParentID = opp[0].ID;
        att.Name = 'Presupuesto Generado ' + dateTimeStr + '.pdf';
        insert att;
    }
    
   
}