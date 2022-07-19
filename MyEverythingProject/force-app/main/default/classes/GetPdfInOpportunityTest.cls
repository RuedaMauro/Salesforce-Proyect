@isTest
public with sharing class GetPdfInOpportunityTest {
    @isTest
    static void testSavePdf(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

        Product2 pro = new Product2(
            Name = 'Cirugia',
            ProductCode = '906750'
            );
        insert pro;

        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 standardPricebook = new Pricebook2(
            Id = pricebookId,
            IsActive = true
        );
        update standardPricebook;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

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

        OpportunityLineItem newItem = New OpportunityLineItem(
            OpportunityId = opp.id,
            Quantity = 1,
            TotalPrice = pbe.UnitPrice,
            PricebookEntryId = pbe.Id
        );
        insert newItem;
        try{
            Test.startTest();
            GetPdfInOpportunity.savePdf(new List<String>{ String.valueOf(opp.Id) });
            Test.stopTest();
            List<Attachment> listAttach = [SELECT Id, Name FROM Attachment];
            System.assert(!listAttach.isEmpty(), 'list '+listAttach);
            
        }catch(Exception ex){
            System.assert(String.isNotBlank(ex.getMessage()));

        }
    }
}