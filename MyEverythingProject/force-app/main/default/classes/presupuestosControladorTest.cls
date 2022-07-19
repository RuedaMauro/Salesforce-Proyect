@isTest
public with sharing class presupuestosControladorTest {
    @isTest
    static void testPage(){
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

        OpportunityLineItem newItem = New OpportunityLineItem(
            OpportunityId = opp.id,
            Quantity = 1,
            TotalPrice = pbe.UnitPrice,
            PricebookEntryId = pbe.Id
        );
        insert newItem;

        Test.startTest();
        PageReference testPage = Page.templatePresupuestos; 
        Test.setCurrentPage(testPage);
        testPage.getParameters().put('Id', String.valueOf(opp.Id));
        
        ApexPages.StandardController sc = new  ApexPages.StandardController(opp);     
        presupuestosControlador ext = new presupuestosControlador(sc);  
        Test.stopTest();
    }
}