public without sharing class LP_SlaProcessSelector extends fflib_SObjectSelector{
    
    public Schema.SObjectType getSObjectType() {
        return SlaProcess.getsObjectType();
    }
    
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            SlaProcess.Id,
            SlaProcess.Name,
            SlaProcess.Description,
            SlaProcess.isActive
        };
    }
    
    public SlaProcess selectByName(String name) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('Name = :name');
        query.setCondition('isActive = true');
        query.setLimit( 1 );
        return (SlaProcess) Database.query( query.toSOQL() );
    }
}