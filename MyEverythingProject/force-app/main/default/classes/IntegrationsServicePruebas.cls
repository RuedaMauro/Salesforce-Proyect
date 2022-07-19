public class IntegrationsServicePruebas {
 public static Date today = System.today();
 public static String offset = '500';
    
    public static final String AGENDA_NAMED_CREDENTIAL = HttpClientFundacionSantaFe.AGENDA_NAMED_CREDENTIAL;
    public static final String EVENTOHC_NAMED_CREDENTIAL = HttpClientFundacionSantaFe.EVENTOHC_NAMED_CREDENTIAL;

    public static String getAgendasResponse(string page) {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            AGENDA_NAMED_CREDENTIAL, '/agenda/crm?offset=' + offset + '&page='+ page + '&date=' + String.valueOf(today.addDays(-1)))
            .setMethod(HttpClient.Method.GET)
            .setTimeOut(120000)
            .send();

        HttpResponse response = client.getResponse();
        return response.getBody();
    }
    
    public static String getEvents(string page) {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            EVENTOHC_NAMED_CREDENTIAL, '/record/events?&offset=' + offset + '&page='+ page)
            .setMethod(HttpClient.Method.GET)
            .send();

		HttpResponse response = client.getResponse();
        return response.getBody();    
    }

    /*public static List<EventoModel> getEvents() {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe('/record/events')
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        return EventoModel.parse(response.getBody());
    }*/

    /* public static List<TutorModel> getTutors() {

        Datetime todayDate = Datetime.now();

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            '/tutors?date=' + String.valueOf(todayDate.date().addDays(-1)))
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        return TutorModel.parse(response.getBody());
    } */

}