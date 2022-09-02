public without sharing class LP_EntitlementSelector extends fflib_SObjectSelector{
    
    public Schema.SObjectType getSObjectType() {
        return Entitlement.sObjectType;
    }
    
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            Entitlement.Id,
            Entitlement.Name,
            Entitlement.AccountId 
        };
    }
    
    public list<Entitlement> selectByAccountId(list<id> listAccountId) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('AccountId IN :listAccountId');
        query.setLimit( 1 );
        return (list<Entitlement>) Database.query( query.toSOQL() );
    }
}