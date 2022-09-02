public without sharing class LP_CasesSelector extends fflib_SObjectSelector{

    public Schema.SObjectType getSObjectType(){
        return Case.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            Case.Id,
            Case.AccountId,
            Case.RecordTypeId,
            Case.Type,
            Case.LP_Nivel1__c,
            Case.LP_Nivel2__c,
            Case.LP_Nivel3__c,
            Case.LP_Ley20009__c
        };
    }

    public list<Case> selectByCaseId(list<Case> listCaseId){
        fflib_QueryFactory query = newQueryFactory();
        query.selectField('RecordType.Name');
        query.setCondition('Id IN :listCaseId');
        return (list<Case>) Database.query( query.toSOQL() );
    }
}