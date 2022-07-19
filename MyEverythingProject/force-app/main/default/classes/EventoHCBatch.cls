global class EventoHCBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{

    global List<HealthCloudGA__EHRProcedure__c> start(Database.BatchableContext BC) {
        return EventosHCHandler.initializeEventoBatch();
    }
     
   global void execute(Database.BatchableContext BC, List<HealthCloudGA__EHRProcedure__c> eventoHCList) {        
               
       Database.UpsertResult [] cr = Database.upsert(eventoHCList, HealthCloudGA__EHRProcedure__c.Id , false);    
       
		/*
		integer contadorDeRegistros = 0;		

		for(HealthCloudGA__EHRProcedure__c eventosAux : eventoHCList)
		{			
			contadorDeRegistros++;
			if(contadorDeRegistros == 50){
				Database.UpsertResult [] cr = Database.upsert(eventosAux, HealthCloudGA__EHRProcedure__c.Id , false);
				contadorDeRegistros = 0;
			}
		}
		if(contadorDeRegistros > 0){
			    Database.UpsertResult [] cr = Database.upsert(eventosAux, HealthCloudGA__EHRProcedure__c.Id , false);
				contadorDeRegistros = 0;
		}
		*/

        for (Database.UpsertResult sr : cr) {
            if (sr.isSuccess()) {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully inserted account. Evento ID: ' + sr.getId());
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