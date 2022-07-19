global class ProfesionalSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        ProfesionalBatch profesionalB = new ProfesionalBatch(); 
       database.executebatch(profesionalB);
    }
 }