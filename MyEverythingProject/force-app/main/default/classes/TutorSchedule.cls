global class TutorSchedule implements Schedulable {
    global void execute(SchedulableContext sc) {
       Tutorbatch tutorB = new Tutorbatch(); 
       database.executebatch(tutorB);
    }
 }