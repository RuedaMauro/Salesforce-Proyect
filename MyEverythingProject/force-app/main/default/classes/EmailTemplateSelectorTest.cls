@isTest
public with sharing class EmailTemplateSelectorTest {
    @isTest
    static void testEmailTemplateSelector(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        Account acc = new Account(
            LastName = 'Test', 
            RecordTypeId = accRecTypeId,
            Numero_de_ID__c = '1012548564',
            Tipo_de_ID__c = '4',
            PersonEmail = 'test@user.com'
        );
        insert acc;

        Opportunity opp = new  Opportunity(
            AccountId = acc.Id,
            Name = 'Web',
            StageName = 'Nuevo presupuesto',
            CloseDate = date.today().addDays(3)
        );
        insert opp;
        

        Test.startTest();
            User thisUser = [select Id from User where Id = :UserInfo.getUserId()];

            System.runAs(thisUser)
            {
                EmailTemplate newEmail = new EmailTemplate(
                isActive = true,
                Name = 'Envio de cotización',
                DeveloperName = 'Envio',
                TemplateType = 'text',
                FolderId = thisUser.Id,
                Subject = 'Your Subject Here'
                );
                insert newEmail;
            }
            
            Account accFromTemp = EmailTemplateSelector.opportunityGetIdAccount(String.valueOf(acc.Id));
            System.assert(accFromTemp != null);
            EmailTemplate emailT = EmailTemplateSelector.getEmailTemplate('Envio de cotización');
            System.assert(emailT != null);
        Test.stopTest();
    }
}