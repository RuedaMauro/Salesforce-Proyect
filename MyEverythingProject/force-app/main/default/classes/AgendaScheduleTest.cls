@isTest
public class AgendaScheduleTest{
     public static testmethod void test1(){
       
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId();

        Account testAcc = new Account(
            FirstName = 'Test',
            LastName = 'GUILLERMO',
            Id_Paciente__c = '1447851',
            Numero_de_ID__c = '987654321',
            Tipo_de_Id__c = '4'
        ); 
        
        insert testAcc;
        system.debug(testAcc);

        HealthCloudGA__EhrCarePlan__c convenio = new HealthCloudGA__EhrCarePlan__c(Codigo_de_convenio_plan__c = '304');
        insert convenio;
       
       	Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Numero_de_ID__c = '98664212'
        );
        insert prof;
       	system.debug(prof);
       
		HealthCloudGA__EHRProcedureRequest__c boletQuirur = new HealthCloudGA__EHRProcedureRequest__c(
            HealthCloudGA__Status__c = 'Sin Derivaciones',
            HealthCloudGA__Account__c = testAcc.id
        );
         
        insert boletQuirur;
        system.debug(boletQuirur);  
       
       	 ServiceAppointment serAppoin = new ServiceAppointment(
             Id_Agenda__c = '2204000253',
             Status= 'AGENDADA',
             Nombre_sede__c = 'Fundación Santa Fe de Bogotá',
             ParentRecordId = testAcc.id,
             Profesional__c = prof.id,
             Detalles_Boleta_Quirurgica__c = boletQuirur.id
         ); 
		
        insert serAppoin;
       	system.debug(serAppoin);
        
         
         
        String hour = String.valueOf(Datetime.now().hour());
        String min = String.valueOf(Datetime.now().minute()); 
        String ss = String.valueOf(Datetime.now().second());
            
            //parse to cron expression
        String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
            
            
   
        Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
       	String CRON_EXP = '0 0 0 3 9 ? 2022';
         
         AgendaSchedule agendaSche = new AgendaSchedule();
         AgendaSchedule agenda = new AgendaSchedule('1','callout','1');
         System.schedule('Schedule Agenda ' + String.valueOf(Datetime.now()), nextFireTime, agenda);
 
         //String jobId = System.schedule('AgendaScheduleTest', CRON_EXP, new AgendaSchedule());
         //CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
         //System.assertEquals(0, ct.TimesTriggered); 
         //System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));
         Test.stopTest();           

     }
}