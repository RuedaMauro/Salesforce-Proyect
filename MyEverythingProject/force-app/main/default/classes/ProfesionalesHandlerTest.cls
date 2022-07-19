@isTest
public class ProfesionalesHandlerTest {
	@isTest static void profesionalGetCallout() { 
        
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId(); 
        
         Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Id_Staff__c = '30273247',
            Tipo_de_Id__c = '4',
            Numero_de_ID__c = '30273247'
        );
        insert prof;
       	system.debug(prof); 
        
     	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ProfesionalesResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);   
        
        Test.startTest(); 
        List<Contact> contList = ProfesionalesHandler.initializeProfessionalBatch();
        Test.stopTest();
        System.assertEquals(1, contList.size());
        System.assertEquals('30273247', contList[0].Numero_de_ID__c); 
 	}
    @isTest static void profesionalPostCallout() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ProfesionalesResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);
        
        Test.startTest();
        Contact contact = ProfesionalesHandler.getProfesional('30273247', '4');
        Test.stopTest();
        System.assertNotEquals(contact, null, 'cannot be null');
        System.assertEquals('30273247', contact.Numero_de_ID__c); 
 	}
}