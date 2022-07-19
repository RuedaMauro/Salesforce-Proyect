@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        // System.assertEquals('https://example.com/example/test', req.getEndpoint());
        // System.assertEquals('GET', req.getMethod());
        
        String body;

        if (req.getEndpoint().contains('/agenda/')) {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'AgendaResponse' LIMIT 1];
            body = sr.Body.toString();
        } else if (req.getEndpoint().contains('/qx/info?pid')) {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'BoletaQuirurResponse' LIMIT 1];
            body = sr.Body.toString();
        } else if (req.getEndpoint().contains('/staff/info')) {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'ProfesionalesResponse' LIMIT 1];
            body = sr.Body.toString();
        } else if (req.getEndpoint().contains('/patients')) {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'PatientResponse' LIMIT 1];
            body = sr.Body.toString();
        } else if (req.getEndpoint().contains('/record/events')) {
            StaticResource sr = [SELECT Id, Body FROM StaticResource WHERE Name = 'EventosHCResponse' LIMIT 1];
            body = sr.Body.toString();
        }

        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(body);
        res.setStatusCode(200);
        return res;
    }
}