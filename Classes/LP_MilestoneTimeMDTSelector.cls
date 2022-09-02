public class LP_MilestoneTimeMDTSelector extends fflib_SObjectSelector{

    public Schema.SObjectType getSObjectType(){
        return LP_MilestoneTime__mdt.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            LP_MilestoneTime__mdt.Id,
            LP_MilestoneTime__mdt.MasterLabel,
            LP_MilestoneTime__mdt.DeveloperName,
            LP_MilestoneTime__mdt.LP_Ley20009__c,
            LP_MilestoneTime__mdt.LP_Negocio__c,
            LP_MilestoneTime__mdt.LP_Nivel1__c,
            LP_MilestoneTime__mdt.LP_Nivel2__c,
            LP_MilestoneTime__mdt.LP_Nivel3__c,
            LP_MilestoneTime__mdt.LP_SLA_Asignacion__c,
            LP_MilestoneTime__mdt.LP_SLA_EnGestion__c,
            LP_MilestoneTime__mdt.LP_SLA_Finalizado__c,
            LP_MilestoneTime__mdt.LP_SLA_Gestionado__c,
            LP_MilestoneTime__mdt.LP_SLATotal__c,
            LP_MilestoneTime__mdt.LP_Tipo__c
        };
    }

    public map<String, LP_MilestoneTime__mdt> selectAllMilestoneTime(){
        fflib_QueryFactory query = newQueryFactory();

        map<String, LP_MilestoneTime__mdt> mapMilestoneTime = new map<String, LP_MilestoneTime__mdt>();
        for(LP_MilestoneTime__mdt item : (list<LP_MilestoneTime__mdt>) Database.query( query.toSOQL() )){
            mapMilestoneTime.put(item.LP_Tipo__c + item.LP_Negocio__c + item.LP_Nivel1__c + item.LP_Nivel2__c + item.LP_Nivel3__c + (item.LP_Ley20009__c == 'Sí'?'Sí':'No'), item);    
        }
        return mapMilestoneTime;
    }
    
}