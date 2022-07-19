global class PacienteBatch implements Database.Batchable<sObject>, Database.AllowsCallouts{


    global List<Account> start(Database.BatchableContext BC) {
        return PacienteHandler.initializePatientBatch();
    }
     
   global void execute(Database.BatchableContext BC, List<Account> accList) {        
         
        System.debug('accList'+ accList);
        
        try {
            upsert accList Account.Id_Paciente__c;  // This line upserts the assets list with
                                            // the Line_Item_Id__c field specified as the 
                                            // Asset field that should be used for matching
                                            // the record that should be upserted. 
        } catch (DmlException e) {
            System.debug(e.getMessage());
        }
       
      /*  Database.UpsertResult [] cr = Database.upsert(accList, Account.Id_Paciente__c, false);          
        for (Database.UpsertResult resolvedCuenta: cr ) {
            if (!resolvedCuenta.isCreated()) {
                System.debug('AccountId'+  resolvedCuenta.getErrors());
                resolvedCuenta.getErrors();
            }     
            System.debug('AccountId'+ resolvedCuenta.getId());
        }*/
    }   
     
    global void finish(Database.BatchableContext BC) {
        
    }
}