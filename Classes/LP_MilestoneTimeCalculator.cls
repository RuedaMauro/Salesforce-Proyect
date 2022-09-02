global class LP_MilestoneTimeCalculator implements Support.MilestoneTriggerTimeCalculator {
    
    private static final String STR_ASIGNACION = 'Asignado';
    private static final String STR_ENGESTION = 'En Gestión';
    private static final String STR_GESTIONADO = 'Gestionado';
    private static final String STR_FINALIZADO = 'Finalizado';
    private static Boolean ISFIRSTTIME = true;
    private static Map<Id, MilestoneType> MTMAP = new Map<Id, MilestoneType>();
    private static Map<Id, Case> CASEMAP = new Map<Id, Case>();

    public LP_MilestoneTimeCalculator (){
        
        if(ISFIRSTTIME) {
            List<Case> cases = new list<Case>(); 

            if (LP_Cases.lstNewAux != null){
                cases = LP_Cases.lstNewAux; 
            }
            
            for (Case c :  new LP_CasesSelector().selectByCaseId(cases)) {
                CASEMAP.put(c.id, c);
            }

            for (MilestoneType m : new LP_MilestoneTypeSelector().selectAllMilestoneType()) {
                MTMAP.put(m.id, m);
            }
            ISFIRSTTIME = false;
        }
        
    }

    
    global Integer calculateMilestoneTriggerTime(String caseId, String milestoneTypeId) {        
   
        Case c =  CASEMAP.get(caseId);
        if(c == null){
            List<Case> cases = new list<Case>(); 
            cases.add(new Case(Id = caseId));
            c = new LP_CasesSelector().selectByCaseId(cases)[0];
        }
        MilestoneType mt = MTMAP.get(milestoneTypeId);

        if (c != null) {
            map<String, LP_MilestoneTime__mdt> mapMilestoneTime = new LP_MilestoneTimeMDTSelector().selectAllMilestoneTime();
            LP_MilestoneTime__mdt obj = mapMilestoneTime.get(c.recordtype.name.substringBefore(' ') + c.type + c.LP_Nivel1__c + c.LP_Nivel2__c + c.LP_Nivel3__c + (c.LP_Ley20009__c == 'Sí'?'Sí':'No'));
            
            if(obj != null) {     
                                    
                if (mt.Name != null && mt.Name.equals(STR_ASIGNACION)) {
                    return Integer.valueOf(obj.LP_SLA_Asignacion__c);
                }
                else if (mt.Name != null && mt.Name.equals(STR_ENGESTION)) {
                    return Integer.valueOf(obj.LP_SLA_EnGestion__c);
                }
                else if (mt.Name != null && mt.Name.equals(STR_GESTIONADO)) {               
                    return Integer.valueOf(obj.LP_SLA_Gestionado__c);

                } else if (mt.Name != null && mt.Name.equals(STR_FINALIZADO)) {
                    return Integer.valueOf(obj.LP_SLA_Finalizado__c);
                }else {
                    
                    return 1;
                }
            } else {                
                return 1;
            }
        }else{                
            return 1;
        }         
    }

}