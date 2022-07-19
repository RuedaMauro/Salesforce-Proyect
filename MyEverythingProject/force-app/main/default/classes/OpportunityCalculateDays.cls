public class OpportunityCalculateDays {
      
    public static Date addBussinessDays(Date startDate, Integer iDays)
{
    Integer businessDaysAdded = 0;
    Date currentDate = startDate;
    while (businessDaysAdded < iDays) {
        currentDate = currentDate.addDays(1);//Se agrega 1 día al día actual
        Datetime d = datetime.newInstance(currentDate.year(), currentDate.month(),currentDate.day());//se genera una instancia de date con la fecha +n
string cadena = d.format('E');
        if (d.format('E') != 'Sun' && checkifItisWorkingDay(currentDate)) {
            // Si es un día de trabajo se le agrega 1 al contador de días
            businessDaysAdded = businessDaysAdded + 1;
        }
    }       
    return currentDate;
}

public static List<Holiday> holidays {
    get {
        if(holidays == null)
            holidays=[Select h.StartTimeInMinutes, h.Name, h.ActivityDate From Holiday h];
        return holidays;
    }
    private set;
}

public static boolean checkifItisWorkingDay(Date currentDate){
    Date weekStart  = currentDate.toStartofWeek();
    
    for(Holiday hDay:holidays){
        if(currentDate.daysBetween(hDay.ActivityDate) == 0){
            return false;
        }
    }
    return true;
  }

}