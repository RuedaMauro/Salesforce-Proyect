@isTest
public class BoletaQuirurgicaHandlerTest {
	@isTest static void BoletaQuirurgicaGetCallout() {
        
        string idOrder = '2112000781';
        string patient = '1434761';
        
        Account testAcc = new Account(
            LastName = 'test',
            Id_Paciente__c = '1434761',
            Numero_de_ID__c = 'NWR2FPJD0',
            Tipo_de_Id__c = 'P',
            PersonEmail = 'test@GMAIL.COM',
            PersonMobilePhone='3158920210'
        ); 
        
        insert testAcc;
        system.debug(testAcc); 
        
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId(); 
        
         Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            //Codigo_del_profesional__c = '100101010',
            Id_Staff__c = '79506091',
            Tipo_de_Id__c = '4',
            Numero_de_ID__c = '79506091'
        );
        insert prof;
       	system.debug(prof); 
        
        
        HealthCloudGA__EHRProcedureRequest__c boletQuirurgica = new HealthCloudGA__EHRProcedureRequest__c(
            HealthCloudGA__Account__c = testAcc.id,
            // Numero_ID_Paciente__c = testAcc.id,
            Profesional__c  = prof.id,
        	Numero_de_orden_medica__c = '2112000781',
            Recursos_especiales__c = 'monitoria intraoperatoria',
            Fecha_de_cirugia__c = Date.ValueOf('2022-01-12'),
            Etapa__c = 'Valor1',
            N_Evento__c = '3',
            Id_BoletaQ__c = '2112000781'
        );
        
        insert boletQuirurgica;
        system.debug(boletQuirurgica); 
        system.debug('fecha*******'+boletQuirurgica.Fecha_de_cirugia__c); 
        
        
        
     	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('BoletaQuirurResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        
        Test.setMock(HttpCalloutMock.class, mock);   
        
        Test.startTest();   
        // List<HealthCloudGA__EHRProcedureRequest__c> contList = BoletaQuirurgicaHandler.initializeBoletaQ(testAcc.Id_Paciente__c,boletQuirurgica.Numero_de_orden_medica__c);
        // System.debug('*************asdasdasd'+contList);
        Test.stopTest();
    }
}