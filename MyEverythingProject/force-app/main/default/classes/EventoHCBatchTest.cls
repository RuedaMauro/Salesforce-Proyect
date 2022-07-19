@isTest
private class EventoHCBatchTest {
    static testmethod void test() {
       Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Acompanante').getRecordTypeId();
       Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId(); 
        
         Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Codigo_del_profesional__c = '100101010',
            Id_Staff__c = '100101010',
            Tipo_de_Id__c = '4',
            Numero_de_ID__c = '100101010'
        );
        insert prof;
       	system.debug(prof); 
        
        
       Account testAcc = new Account(
            LastName = 'test',
            Id_Paciente__c = '1448097',
            Numero_de_ID__c = '93298390',
            Tipo_de_Id__c = '4',
            PersonEmail = 'test@GMAIL.COM',
            PersonMobilePhone='3158920210',
            Id_Tutor__c = '1015413113'
        ); 
        
        insert testAcc;
        system.debug(testAcc); 
        
       Account testAccTutor = new Account(
          	RecordTypeId = accRecTypeId,
            //Id_Paciente__c = '1448097',
            Id_Paciente__c = '1015413113',
            LastName = 'pruebas',
            PersonEmail = 'asds@fmas.com',
            PersonMobilePhone = '1232134234'
        ); 
        
        insert testAccTutor;
        system.debug(testAccTutor); 
        
        HealthCloudGA__EHRProcedure__c eventosHC = new HealthCloudGA__EHRProcedure__c(
        	HealthCloudGA__Account__c = testAcc.id,
            Nombre_Profesional__c = prof.id,
            Acompanante_o_Responsable__c = testAccTutor.id,
            Valor_facturado_paciente__c = 123123,
			Valor_facturado_convenio__c = 123123123
        );
        
        
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('EventosHCResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json'); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock); 
        EventoHCBatch b = new EventoHCBatch();
        Database.executeBatch(b);
        Test.stopTest();
    }
}