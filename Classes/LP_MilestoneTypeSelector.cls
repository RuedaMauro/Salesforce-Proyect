public without sharing class LP_MilestoneTypeSelector  extends fflib_SObjectSelector{

    public Schema.SObjectType getSObjectType(){
        return MilestoneType.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            MilestoneType.Id,
            MilestoneType.Name
        };
    }

    public list<MilestoneType> selectAllMilestoneType(){
        fflib_QueryFactory query = newQueryFactory();
        return (list<MilestoneType>) Database.query( query.toSOQL() );
    }
}