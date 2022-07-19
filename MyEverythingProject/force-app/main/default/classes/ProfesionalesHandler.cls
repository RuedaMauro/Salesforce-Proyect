public with sharing class ProfesionalesHandler {

    public static final Id CONTACT_RECORDTYPE_ID =
        RecordTypesService.getRecordTypeId(Contact.getSObjectType(), 'Profesional');

    public static List<Contact> initializeProfessionalBatch() {

        List<Contact> result = new List<Contact>();
        Datetime todayDate = Datetime.now();

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
                '/staff?date=' + String.valueOf(todayDate.date().addDays(-1)))
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();

        List<ProfessionalModel> models = ProfessionalModel.parse(response.getBody());

        for(ProfessionalModel model : models) result.add(getContactFromParser(model));

        return result;
    }

    public static Contact getProfesional(String docNumber, String tdocCode) {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe('/staff/info')
            .setBody(JSON.serialize(new Map<String, Object>{ 'doc'=> docNumber, 'tdoc' => tdocCode }))
            .setMethod(HttpClient.Method.POST)
            .send();

        HttpResponse response = client.getResponse();
		system.debug('responseProfesional::::'+response);
        
        return getContactFromParser(ProfessionalModel.parse(response.getBody())[0]);

    }

    public static Contact getContactFromParser(ProfessionalModel model) {
        return new Contact(
            RecordTypeId = CONTACT_RECORDTYPE_ID,
            Numero_de_ID__c = model.id_staff,
            Tipo_de_Id__c = model.doc_type?.code,
            FirstName = model.name,
            LastName = model.paternal_surname,
            MobilePhone = model.mobile,
            Email = model.email?.contains('@') == true ? model.email : null,
            Especialidad__c = model.specialty?.detail,
            sub_especialidad__c = model.sub_specialty?.detail
        );
    }

    public static Map<String, Contact> getContactByNumeroDeId(Set<String> numerosDeId) {
        Map<String,Contact> result = new Map<String,Contact>();

        for (Contact con : [SELECT Id, Numero_de_ID__c, LastName FROM Contact
            WHERE Numero_de_ID__c IN :numerosDeId  AND RecordTypeId =: CONTACT_RECORDTYPE_ID])
            result.put(con.Numero_de_ID__c, con);

        return result;
    }
}