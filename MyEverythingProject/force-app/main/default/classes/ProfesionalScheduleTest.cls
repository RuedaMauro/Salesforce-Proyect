@isTest(SeeAllData=true)
public class ProfesionalScheduleTest{
     public static testmethod void test1(){
        
        
         
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ProfesionalesResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
      	Test.startTest(); 
 		Test.setMock(HttpCalloutMock.class, mock); 
      	String CRON_EXP = '0 0 0 3 9 ? 2022';
        String jobId = System.schedule('ProfesionalScheduleTest', CRON_EXP, new ProfesionalSchedule());
      	Test.stopTest();           
      	CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];          
      	System.assertEquals(0, ct.TimesTriggered); 
      	System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));  
     }
}