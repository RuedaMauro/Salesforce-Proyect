global class PacienteSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
       PacienteBatch b = new PacienteBatch(); 
       database.executebatch(b);
    }
 }