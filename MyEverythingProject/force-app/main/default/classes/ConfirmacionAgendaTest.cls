@isTest
public class ConfirmacionAgendaTest {
 @isTest
    public static void confirmServiceAppointmentTest(){
    
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        DateTime myDateTime = DateTime.newInstance(1997, 1, 31, 7, 8, 16);

         Account testAcc = new Account(
         	LastName = 'Test', 
            //RecordTypeId = accRecTypeId,
            Numero_de_ID__c = '430088',
            Tipo_de_ID__c = '4',
            PersonEmail = 'test@user.com'
         ); 
        
        insert testAcc;
        
       	 ServiceAppointment serAppoin = new ServiceAppointment(
             Status= 'Cancelada',
             Nombre_sede__c = 'Fundación Santa Fe de Bogotá',
             ParentRecordId = testAcc.id,
             Fecha_y_Hora_agenda__c = myDateTime.addHours(3)
         ); 
		
        insert serAppoin;
             
	
        
       Test.startTest(); 
       pageReference pageRefe = Page.ConfirmacionAgenda;
       Test.setCurrentPage(pageRefe);
       pageRefe.getParameters().put('Id', String.valueOf(serAppoin.Id));
       
       ConfirmacionAgenda confAgenda = new ConfirmacionAgenda();
	           
       ServiceAppointment serAppo = confAgenda.getAgenda();
	   Account acct = confAgenda.getPaciente();
       
       confAgenda.confirmaAgenda = true; 
       confAgenda.datatimeAgenda = serAppoin.Fecha_y_Hora_agenda__c - (1/4.8);
        
       confAgenda.confirmAgenda();
       Test.stopTest(); 
    
       List<ServiceAppointment> listServAppo = [SELECT Id, Confirmacion_de_agenda__c FROM ServiceAppointment WHERE Id =: serAppo.id];
       
       System.assert(listServAppo[0].Confirmacion_de_agenda__c, ListServAppo + 'servin' + serAppo);

    }
}