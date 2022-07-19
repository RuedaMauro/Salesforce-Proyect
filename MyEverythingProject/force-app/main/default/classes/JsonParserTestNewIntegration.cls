public with sharing class JsonParserTestNewIntegration
{
	
    public static HTTPResponse doRequest()
    {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://z0uvjb37lj.execute-api.us-east-1.amazonaws.com/V1/patients?date=2022-03-15');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        return res;
    }
    public static List<Account> initializeAccounts() {
        
        HTTPResponse response = doRequest();
        String responseBody = response.getBody();

        JSONParser parser = JSON.createParser(responseBody);
        Set<String> idPatients = new Set<String>();
        List<Account> patientList = new List<Account>();
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (parser.nextToken() != null) {
                    if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        PatientParser parsed = (PatientParser) parser.readValueAs(PatientParser.class);
                        Account patient = getAccountFromParser(parsed);
                        patientList.add(patient);
                        idPatients.add(patient.Id_Paciente__c);
                        parser.skipChildren();
                    }
                }
            }
        }

        addIdToExistingPatients(patientList, getIdByIdPaciente(idPatients));

        return patientList;
    }

    public static void addIdToExistingPatients(List<Account> allAccounts, Map<String, Id> idByIdPaciente)
    {
        for (Account record : allAccounts)
        {
            if (idByIdPaciente.containskey(record.Id_Paciente__c))
            {
                record.Id = idByIdPaciente.get(record.Id_Paciente__c);
            }
        }
    }

    public static Map<String, Id> getIdByIdPaciente(Set<String> idPacientes)
    {
        Map<String, Id> result = new Map<String, Id>();
        for (Account record : [SELECT Id, Id_Paciente__c FROM Account WHERE Id_Paciente__c IN: idPacientes])
        {
            result.put(record.Id_Paciente__c, record.Id);
        }
        return result;
    }

    public static Account getAccountFromParser(PatientParser toParse)
    {
        system.debug('getAccountFromParser'+toParse);
        return new Account(
            Id_Paciente__c = toParse.id_patient,
            Numero_de_ID__c = toParse.doc
            
        );
        
    }

    public class PatientParser {
        public String id_patient;
        public String doc;
        
    }
}