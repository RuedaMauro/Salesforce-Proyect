public with sharing class PacienteHandler {

    public static final Id ACCOUNT_RECORDTYPE_ID =
        RecordTypesService.getRecordTypeId(Account.getSObjectType(), 'PersonAccount');

    public static List<Account> initializePatientBatch() {

        List<Account> result = new List<Account>();

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
                '/patients?date=' + String.valueOf(System.now().date().addDays(-1)))
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();

        for(PatientModel model : PatientModel.parse(response.getBody())) result.add(getAccountFromPatientModel(model));

        return result;
    }

    public static Account getPaciente(String docNumber, String tdocCode) {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe('/patients/info')
            .setMethod(HttpClient.Method.POST)
            .setBody(JSON.serialize(new Map<String, Object>{ 'doc'=> docNumber, 'tdoc' => tdocCode }))
            .send();

        HttpResponse response = client.getResponse();

        List<PatientModel> result = PatientModel.parse(response.getBody());
        if (result.size() != 0)
            return getAccountFromPatientModel(PatientModel.parse(response.getBody())[0]);
        else
            return null;
    }

    public static Account getAccountFromPatientModel(PatientModel patient) {
		System.debug('EMAIL:::::::'+patient);
        
        return new Account(
            Celular_del_Paciente__c = patient.mobile != null ? patient.mobile : null,
            Ciudad_de_residencia__c = patient.city_residence != null ? patient.city_residence : null,
            Estado_Civil__c = patient.civil_status?.detail != null ? patient.civil_status?.detail : null,
            FirstName = patient.names != null ? patient.names : null,
            Habeas_Data__c = patient.accept_habeas == 'S',
            Id_Paciente__c = patient.id_patient != null ? patient.id_patient : null,
            LastName = patient.last_name != null ? patient.last_name : null,
            Numero_de_ID__c = patient.doc != null ? patient.doc : null,
            Pais_de_residencia__c = patient.country_residence?.detail != null ? patient.country_residence?.detail : null,
            PersonBirthdate = patient.birtdate != null && String.isNotBlank(patient.birtdate) ? Date.valueOf(patient.birtdate) : null,
            PersonEmail = patient.email != null && String.isNotBlank(patient.email) && String.valueOf(patient.email).contains('@') && !String.valueOf(patient.email).contains('ñ') ? patient.email : null,
            Phone = patient.phone != null ? patient.phone : null,
            RecordTypeId = ACCOUNT_RECORDTYPE_ID,
            Sexo__c = patient.gender != null && String.valueOf(patient.gender).toLowerCase() == 'f' ? 'Femenino' : 'Masculino',
            Tipo_de_Id__c = patient.tdoc?.code != null ? patient.tdoc?.code : null
        );
    }

}