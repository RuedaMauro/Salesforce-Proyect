public class HttpClientFundacionSantaFe extends HttpClient {
    public static final String NAMED_CREDENTIAL = 'callout:Name_Credential_Deshc';
    public static final String AGENDA_NAMED_CREDENTIAL = 'callout:Name_Credential_Agenda';
    public static final String EVENTOHC_NAMED_CREDENTIAL = 'callout:Name_Credential_EventoHC';

    public HttpClientFundacionSantaFe(String path) {
        super();
        setHeader();
        setTimeout(120000);
        setEndpoint(NAMED_CREDENTIAL + path);
    }
    
    public HttpClientFundacionSantaFe(String namedCredentional, String path) {
        super();
        setHeader();
        setTimeout(120000);
        setEndpoint(namedCredentional + path);
    }

    public override HttpClient setMethod(Method value) {
        request.setMethod(value.name());
        method = value;
        if (value == HttpClient.Method.POST) request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        return this;
    }

    private void setHeader() {
        for (Integration_Header__mdt header : [SELECT Key__c, Value__c  FROM Integration_Header__mdt])
            this.request.setHeader(header.Key__c, header.Value__c);
    }
}