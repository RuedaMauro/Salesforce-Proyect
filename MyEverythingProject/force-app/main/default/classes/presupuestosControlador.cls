public with sharing class presupuestosControlador {
    
    public List<OpportunityLineItem> lstObjectBs{get;set;}
    public List<Account> acc{get;set;}
    public List<Opportunity> opp{get;set;}
    public List<Product2> prod{get;set;}
    public Id OppId;
    public presupuestosControlador(ApexPages.StandardController con){
        OppId = System.currentPageReference().getParameters().get('Id');
        opp = new List<Opportunity>([SELECT Id,Numero_ID_solicitante__c,Tipo_ID_Solicitante__c,Correo_electronico_solicitante__c,AccountId,Amount, Consecutivo_presupuesto__c FROM Opportunity WHERE Id =:OppId]);
        acc = new List<Account>([SELECT Name FROM Account WHERE Id =: opp[0].AccountId]);
        lstObjectBs = new List<OpportunityLineItem>([SELECT  Name,Product2Id,ProductCode, Quantity, Product2.name FROM OpportunityLineItem WHERE OpportunityId =: OppId]);
    	prod = new List<Product2>([SELECT Name FROM Product2 WHERE Id =: lstObjectBs[0].Product2Id]);
            
    }

    
    

}