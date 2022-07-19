global class ProfesionalBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    global List<Contact> start(Database.BatchableContext BC) {
        return ProfesionalesHandler.initializeProfessionalBatch();
    }
     
   global void execute(Database.BatchableContext BC, List<Contact> contList) {        
               
       Database.UpsertResult [] cr = Database.upsert(contList, Contact.Numero_de_ID__c, false);    
       /*Database.Error [] errors = cr.getErrors();
       System.debug('errors'+errors);
        for (Database.Error resolvedContact: errors ) {
            resolvedContact.getMessage();
        }*/

        for (Database.UpsertResult sr : cr) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Account ID: ' + sr.getId());
            }
            else {
                // Operation failed, so get all errors                
                for(Database.Error err : sr.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }   
     
    global void finish(Database.BatchableContext BC) {
        
    }
}