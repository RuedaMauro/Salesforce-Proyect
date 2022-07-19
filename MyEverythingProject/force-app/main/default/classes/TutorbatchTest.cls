@isTest
public class TutorbatchTest {
     static testmethod void test() {
        
        Account patientAcc = new Account();
        patientAcc.Id_Paciente__c='1447759';
        patientAcc.LastName='testUser';
		patientAcc.PersonEmail='tesUs@gmail.com';
        patientAcc.PersonMobilePhone='3454567';
        
        insert patientAcc;	
        System.debug(patientAcc); 
        
	 	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('TutorResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock); 
        TutorBatch b = new TutorBatch();
        Database.executeBatch(b);
        Test.stopTest();
     }
}