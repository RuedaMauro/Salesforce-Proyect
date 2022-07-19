global class EstadosAgendaBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    global List<ServiceAppointment> start(Database.BatchableContext BC) {
        return [SELECT Valor_de_Servicio__c, Status, Id_Agenda__c,DueDate, Fecha_y_Hora_agenda__c, Observaciones_de_la_gestion__c, Celular_Paciente__c, Convenio_de_paciente__c, Account.Name, Account.RecordType.DeveloperName, Reenvio_de_datos__c,
                (
                    SELECT Persona_aprobadora__c,Numero_de_autorizacion__c,Codigo_de_Convenio_plan__c, Costo_convenio__c, Costo_Paciente__c,Fecha_de_autorizacion__c, Fecha_de_vencimiento_de_la_autorizacion__c, Estado_de_la_autorizacion__c
                    FROM Autorizaciones__r WHERE Agenda__c != NULL ORDER BY CreatedDate Desc LIMIT 1
                )
                FROM ServiceAppointment WHERE Confirmacion_de_agenda__c = true AND Gestionable__c = 'Si' AND Id_Agenda__c != NULL LIMIT 1]; 
    }
     
   global void execute(Database.BatchableContext BC, List<ServiceAppointment> serviceApppList) {       
        EstadosAgendaHandler.makePostCallout(serviceApppList);
    }   
     
    global void finish(Database.BatchableContext BC) {
        
    }
}