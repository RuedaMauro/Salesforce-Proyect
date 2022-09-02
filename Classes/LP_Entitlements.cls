public with sharing class LP_Entitlements extends fflib_SObjectDomain{
    
    public LP_Entitlements(List<Entitlement> sObjectList) {
        super(sObjectList);
    }
    
    public void createEntitlements(list<Account> accounts) {
        list<Entitlement> listEntitlement = new list<Entitlement>();
        SlaProcess sProcess = new LP_SlaProcessSelector().selectByName('Proceso de Asignación Casos');
        
        for(Account acc : accounts) {
            Entitlement newEntitlement = new Entitlement();
            newEntitlement.AccountId = acc.id;        
            newEntitlement.SlaProcessId = sProcess.Id;
            newEntitlement.Name = sProcess.Name;
            newEntitlement.StartDate = Date.today();
            listEntitlement.add(newEntitlement);
        }
        insert listEntitlement;
    }
    
}