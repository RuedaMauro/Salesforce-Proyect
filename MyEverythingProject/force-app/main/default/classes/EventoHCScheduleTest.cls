@isTest
private class EventoHCScheduleTest {
	 static testmethod void test1(){
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
			Valor_facturado_convenio__c = 123123123,
            Numero_de_Evento__c = 0            
        );
        
        insert eventosHC;
         
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute()); 
        String ss = String.valueOf(Datetime.now().second());
            
            //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
            
            
   
        Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
       	String CRON_EXP = '0 0 0 3 9 ? 2022';
         
        EventoHCSchedule eventoSche = new EventoHCSchedule();
        EventoHCSchedule evento = new EventoHCSchedule('1','callout','1');
        System.schedule('Schedule evento ' + String.valueOf(Datetime.now()), nextFireTime, evento);
 
         //String jobId = System.schedule('AgendaScheduleTest', CRON_EXP, new AgendaSchedule());
         //CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
         //System.assertEquals(0, ct.TimesTriggered); 
         //System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
         Test.stopTest();            
         
     }
}