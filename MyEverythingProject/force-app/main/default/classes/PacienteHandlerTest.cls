@isTest
public class PacienteHandlerTest {
 @isTest static void patientGetCallout() {
        
     	Account pacienteAcct = new Account(
            LastName = 'test',
            Id_Paciente__c = '1447837',
            Numero_de_ID__c = '107242674759',
            Tipo_de_Id__c = '4',
            PersonEmail = 'test@GMAIL.COM',
            PersonMobilePhone='3158920210'
        );
     	insert pacienteAcct;
     

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
        Test.startTest(); 
        List<Account> accList = PacienteHandler.initializePatientBatch();
        Test.stopTest();
        System.assertEquals(1, accList.size());
        System.assertEquals('107242674759', accList[0].Numero_de_ID__c); 
 	}
    @isTest static void patientPostCallout() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        Account account = PacienteHandler.getPaciente('1447837', '4');
        Test.stopTest();
        System.assertNotEquals(account, null, 'should not be null');
        System.assertEquals('107242674759', account.Numero_de_ID__c); 
 	}
}