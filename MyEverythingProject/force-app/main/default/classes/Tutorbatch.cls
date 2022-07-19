global class Tutorbatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    global List<AccountContactRelation> start(Database.BatchableContext BC) {
        return TutorHandler.initializeTutorBatch();
    }
     
   global void execute(Database.BatchableContext BC, List<AccountContactRelation> listAccConRole) { 
       
                        
    Database.SaveResult[] lsr = Database.insert(listAccConRole,false);
        
    for (Database.SaveResult sr : lsr) {
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