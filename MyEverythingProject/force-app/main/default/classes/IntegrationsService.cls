public with sharing class IntegrationsService {

    public static Date today = System.today();

    public static final String AGENDA_NAMED_CREDENTIAL = HttpClientFundacionSantaFe.AGENDA_NAMED_CREDENTIAL;
    public static final String EVENTOHC_NAMED_CREDENTIAL = HttpClientFundacionSantaFe.EVENTOHC_NAMED_CREDENTIAL;

    public static List<AgendaModel> getAgendas() {

        return AgendaModel.parse(getAgendasResponse());
    }
    
    public static String getAgendasResponse() {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            AGENDA_NAMED_CREDENTIAL, '/agenda/crm?date=' + String.valueOf(today.addDays(-4)))
            .setMethod(HttpClient.Method.GET)
            .setTimeOut(120000)
            .send();

        HttpResponse response = client.getResponse();
        return response.getBody();
    }
    
    public static List<EventoModel> getEvents() {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            EVENTOHC_NAMED_CREDENTIAL, '/record/events')
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        return EventoModel.parse(response.getBody());
    }

    /*public static List<EventoModel> getEvents() {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe('/record/events')
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        return EventoModel.parse(response.getBody());
    }*/

    public static List<TutorModel> getTutors() {

        Datetime todayDate = Datetime.now();

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            '/tutors?date=' + String.valueOf(todayDate.date().addDays(-1)))
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        return TutorModel.parse(response.getBody());
    }
}