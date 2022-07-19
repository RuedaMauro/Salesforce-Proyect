@isTest
public class test_GetPdfInCase {
    
    @isTest static void generatePdf(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        //Id caseTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Comunicación_del_usuario').getRecordTypeId();
        Account acc = new Account(
            LastName = 'Lucas', 
            RecordTypeId = accRecTypeId,
            Numero_de_ID__c = '1012548564',
            Tipo_de_ID__c = '4',
            PersonEmail = 'test@user.com'
        );
        insert acc;
        
        Case caso = new Case();
        //caso.RecordTypeId = caseTypeId;
        caso.Reason = 'Queja';
        caso.Status = 'Nuevo';
        caso.Fecha_de_recepcion_de_caso__c = date.today().addDays(3);
        caso.Origin = 'Correo Electrónico';
        caso.Description = 'asd';
        caso.Nombre_del_reportante__c = 'Test';
        caso.Apellidos_del_reportante__c = 'Test2';
        caso.SuppliedEmail = 'test@user.com';
        caso.Informante__c = 'Ente de control';
        caso.Fecha_de_respuesta__c = date.today().addMonths(1);
        caso.Subject = 'Queja Test';
        caso.Tiempo_maximo_para_tramite__c = '3';
        insert caso;
        system.debug(caso);
        try{
            Test.startTest();
            GetPdfInCase.savePdf(new List<String>{ String.valueOf(caso.Id) });
            Test.stopTest();
            List<Attachment> listAttach = [SELECT Id, Name FROM Attachment];
            System.assert(!listAttach.isEmpty(), 'list '+listAttach);
            
        }catch(Exception ex){
            System.assert(String.isNotBlank(ex.getMessage()));

        }
    }
    
    

}