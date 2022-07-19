global class EstadosAgendaSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
        EstadosAgendaBatch estadosAgenda = new EstadosAgendaBatch(); 
       database.executebatch(estadosAgenda);
    }
 }