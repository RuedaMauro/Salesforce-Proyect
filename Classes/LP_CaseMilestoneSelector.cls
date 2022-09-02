public with sharing class LP_CaseMilestoneSelector extends fflib_SObjectSelector{

    public Schema.SObjectType getSObjectType(){
        return CaseMilestone.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            CaseMilestone.Id,
            CaseMilestone.CaseId
        };
    }

    public list<CaseMilestone> selectCaseMilestoneByCaseId(list<Case> listCaseId){
        fflib_QueryFactory query = newQueryFactory();
        query.selectField('MilestoneType.Name');
        query.setCondition('CaseId IN :listCaseId');
        return (list<CaseMilestone>) Database.query( query.toSOQL() );
    }
}