@isTest
public class EstadosAgendaHandlerTest {
    @isTest
    static void patientPostCallout() {              
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId();
        Id tutorRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Acompanante').getRecordTypeId();

        Account testAcc = new Account(
            LastName = 'GUILLERMO ANTONIO',
            Id_Paciente__c = '1014281',
            Tipo_de_Id__c = '4',
            PersonEmail = 'test@GMAIL.COM',
            PersonMobilePhone='3158920210'
            
        ); 
        
        insert testAcc;
        system.debug(testAcc);
       
       	Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Codigo_del_profesional__c = '30273247',
            Nombre_del_paciente__c = testAcc.Id
        );
        insert prof;
       	system.debug(prof);
        
        Contact tutor = new Contact(
            RecordTypeId = tutorRecTypeId,
            LastName = 'acompanante',
            Numero_de_ID__c = '123213213',
            Tipo_de_ID__c = '4'
        );
        insert tutor;
       	system.debug(tutor);
       
        HealthCloudGA__EhrCarePlan__c convenio = new HealthCloudGA__EhrCarePlan__c (
        	Codigo_de_convenio_plan__c = 'PLUS AMERICA',
            Nombre_de_convenio_plan__c = 'GRUPO EUROPA',
            Gestionable__c = 'Si',
            HealthCloudGA__Account__c = testAcc.id
        );
        
        insert convenio;
        
        Convenios_de_paciente__c pacienteConvenio = new Convenios_de_paciente__c(
        	Paciente__c = testAcc.id,
            Convenio__c = convenio.id
        );
        insert pacienteConvenio;
        
        
       	ServiceAppointment serAppoin = new ServiceAppointment(
             Id_Agenda__c = '2204000253',
             Status= 'AGENDADA',
             Nombre_sede__c = 'Fundación Santa Fe de Bogotá',
             ParentRecordId = testAcc.id,
             Profesional__c = prof.id,
             Confirmacion_de_agenda__c = true
        ); 
		
        insert serAppoin;
       	system.debug(serAppoin);
		
        Autorizacion__c autorizacion = new Autorizacion__c(
        	Agenda__c = serAppoin.id,
            Paciente__c = testAcc.id,
            //Numero_de_autorizacion__c = 18600,
            Fecha_de_vencimiento_de_la_autorizacion__c = Date.ValueOf('2022-05-05'),
            Costo_paciente__c = 0,
            Tipo_de_agenda__c = 'Presencial',
            Estado_de_la_autorizacion__c = 'Nuevo',
            Convenio_de_paciente__c = pacienteConvenio.id
        );
        insert autorizacion;
        
        List<ServiceAppointment> Agenda = new List<ServiceAppointment>();
        
        agenda.add(serAppoin);
        
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('EstadosAgendaResponse'); 
       	mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);
        List<ServiceAppointment> serviceApp = new List<ServiceAppointment>([SELECT Valor_de_Servicio__c, Status, Id_Agenda__c,DueDate, Fecha_y_Hora_agenda__c, Observaciones_de_la_gestion__c, Celular_Paciente__c, Convenio_de_paciente__c, Account.Name, Account.RecordType.DeveloperName, Reenvio_de_datos__c,
                                                (
                                                    SELECT Persona_aprobadora__c,Numero_de_autorizacion__c,Codigo_de_Convenio_plan__c, Costo_convenio__c, Costo_Paciente__c,Fecha_de_autorizacion__c, Fecha_de_vencimiento_de_la_autorizacion__c, Estado_de_la_autorizacion__c
                                                    FROM Autorizaciones__r WHERE Agenda__c != NULL LIMIT 1
                                                )
                                                FROM ServiceAppointment WHERE id =: serAppoin.id]); 
        system.debug('citasdeservicio**********'+serviceApp);
        //List<ServiceAppointment> service = [SELECT FIELDS(ALL) FROM ServiceAppointment WHERE Confirmacion_de_agenda__c = true];
        
        Test.startTest();
            EstadosAgendaHandler.makePostCallout(serviceApp);
        Test.stopTest();
        //System.assertEquals(1, accList.size());
        //System.assertEquals('77044694', accList[0].Numero_de_ID__c); 
	
	}
}