public without sharing class OpportunityCreationController {
    
    private final Account cuenta {get;set;}
    @AuraEnabled
    
    
    public static Account getAccount(string get){
        Account acc = new Account();
        try{
            	acc = [SELECT Id FROM Account ORDER BY CreatedDate DESC LIMIT 1];
                return acc;
           }
           catch(System.QueryException e){
			System.debug(e.getMessage());
			return null;
           }

      }
    
  
    
 // the function insert date of today and sum two days because the field endTime of opportunity is required
    public static Date fecha(String getDate){
        
        DateTime fecha = Date.today();
        DateTime newDate = fecha.addDays(3);
        Date fechaActual = date.newinstance(newDate.year(), newDate.month(), newDate.day());
        return fechaActual;
    }
      @AuraEnabled
    // create new opportunity
	public static Opportunity insertOpportunity(Opportunity opp){
     	
        List<Account> acc = new List<Account>([SELECT Id FROM Account ORDER BY CreatedDate DESC LIMIT 1]);
        Opp.AccountId = opp.Id;
        Opp.Name = 'web';
        Opp.StageName = 'Nuevo presupuesto';
        Opp.CloseDate = date.today().addDays(3);
        Opp.ForecastCategoryName = 'Omitted';
        opp.Amount=50000;
        insert Opp;
        return Opp;
    }
}