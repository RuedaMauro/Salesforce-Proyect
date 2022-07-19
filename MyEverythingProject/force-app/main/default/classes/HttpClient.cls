public virtual class HttpClient {

    public enum Method { GET, POST, PUT }

    public HttpClient() {}

    protected HttpRequest request = new HttpRequest();
    protected HttpResponse response;
    protected Method method;
    protected String endPoint;

    public virtual HttpClient setEndpoint(String endPoint) {
        request.setEndpoint(endpoint);
        this.endPoint = endPoint;
        return this;
    }

    public virtual HttpClient setMethod(Method value) {
        request.setMethod(value.name());
        this.method = value;
        return this;
    }

    public virtual HttpClient setBody(String body) {
        if (String.isNotBlank(body)) request.setBody(body);
        return this;
    }

    public virtual HttpClient send() {

        if (String.isBlank(this.method.name())) throw new HttpClientException('Method is required');
        if (String.isBlank(this.endPoint)) throw new HttpClientException('endPoint is required');

        response = new Http().send(request);
        return this;
    }

    public virtual HttpResponse getResponse() {
        return response;
    }

    public virtual HttpClient setHeader(String key, String value) {
        request.setHeader(key, value);
        return this;
    }

    public virtual HttpClient setTimeOut(Integer timeOut) {
        request.setTimeout(timeOut);
        return this;
    }

    public class HttpClientException extends Exception {}
}