public with sharing class TutorHandler {

    public static List<AccountContactRelation> initializeTutorBatch() {
        
        List<TutorModel> models = IntegrationsService.getTutors();
        List<AccountContactRelation> accContR = new List<AccountContactRelation>();

        if (models.isEmpty()) return new List<AccountContactRelation>{};

        for(TutorPaciente tutorP : createMaps(models)) accContR.add(tutorP.relacion);

        return accContR;
    }

        public static List<Account> getTutor(String docNumber, String tdocCode) {
            List<Account> listAccContToUpsert = new List<Account>();
            HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
                '/tutors/info')
                .setBody(JSON.serialize(new Map<String, Object>{ 'doc'=> docNumber, 'tdoc' => tdocCode }))
                .setMethod(HttpClient.Method.POST)
                .send();

            HttpResponse response = client.getResponse();

           /*  List<TutorModel> models =
                (List<TutorModel>) JSON.deserialize(response.getBody(), List<TutorModel>.class); */
                List<TutorModel> models = TutorModel.parse(response.getBody());

            if (models.isEmpty()) return new List<Account>{};

            for(TutorPaciente tutorP : createMaps(models)) listAccContToUpsert.add(tutorP.tutor);

            return listAccContToUpsert;
        }

        public static List<TutorPaciente> createMaps(List<TutorModel> models) {
            Map<String, TutorModel> mapIdObject = new Map<String, TutorModel>();
            Map<String, Account> mapPatientReturn = new Map<String, Account>();

            for(TutorModel model : models) mapIdObject.put(model.id_patient, model);

            List<Account> listPatient = [SELECT Id, Id_Paciente__c FROM Account WHERE Id_Paciente__c IN: mapIdObject.keySet()];

            for (Account paciente : listPatient) mapPatientReturn.put(paciente.Id_Paciente__c, paciente);
            
            return !mapIdObject.isEmpty() ? createTutor(mapIdObject, mapPatientReturn) : new List<TutorPaciente>{};
        }

        public static List<TutorPaciente> createTutor(Map<String, TutorModel> mapIdObject, Map<String, Account> mapPatientReturn ) {
            Map<String, Account> mapAccountToInsert = new Map<String, Account>();
            List<TutorPaciente> listTutorPat = new List<TutorPaciente>();
            List<Account> listAccTutors = new List<Account>();
            List<String> listIdTutors = new List<String>();
            for (String idPaciente : mapIdObject.keySet()) {
                TutorPaciente tutorPat  = new tutorPaciente();
                tutorPat.Paciente = mapPatientReturn.containsKey(idPaciente)
                    ? mapPatientReturn.get(idPaciente)
                    : PacienteHandler.getPaciente(mapIdObject.get(idPaciente).patient.doc_number, mapIdObject.get(idPaciente).patient.tdoc.code);
                if (String.isBlank(String.valueOf(tutorPat.Paciente.Id)))
                    mapAccountToInsert.put(tutorPat.Paciente.Id_Paciente__c,tutorPat.Paciente);
                tutorPat.tutor = getTutorFromParser(mapIdObject.get(idPaciente));
                listTutorPat.add(tutorPat);
                listAccTutors.add(tutorPat.tutor);
                listIdTutors.add(tutorPat.tutor.Id_Tutor__pc);
            }
            try {
                insert mapAccountToInsert.values();
                upsert listAccTutors Id_Tutor__c;
                Map<String, Contact> mapIdContact = new Map<String, Contact>();
                List<Contact> listcont = [SELECT Id, Id_Tutor__c FROM Contact WHERE Id_Tutor__c IN : listIdTutors];

                for(Contact con : listcont) mapIdContact.put(con.Id_Tutor__c, con);

                for(TutorHandler.TutorPaciente tutorPat : listTutorPat) {
                    AccountContactRelation relation = new AccountContactRelation(
                        AccountId = tutorPat.paciente.Id,
                        ContactId = mapIdContact.get(tutorPat.tutor.Id_Tutor__pc).Id,
                        Roles = 'Otro'
                    );
                    tutorPat.relacion = relation;
                }
            } catch (Exception ex) {
                System.debug('error '+ex.getMessage());
            }
            return listTutorPat;
        }

        public static Account getTutorFromParser(TutorModel model) {
            Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Acompanante').getRecordTypeId();
            return new Account(
                RecordTypeId = accRecTypeId,
                Id_Tutor__c = String.valueOf(model.id_tutor),
                Id_Tutor__pc = String.valueOf(model.id_tutor),
                Tipo_de_Id__c = String.valueOf(model.tdoc?.code),
                Tipo_de_Id__pc = String.valueOf(model.tdoc?.code),
                Numero_de_ID__c = String.valueOf(model.doc),
                Numero_de_ID__pc = String.valueOf(model.doc),
                LastName = String.valueOf(model.full_name),
                Celular_del_Paciente__c = String.valueOf(model.mobile),
                PersonMobilePhone = String.valueOf(model.mobile),
                PersonEmail = model.email != null ? (model.email?.contains('@') ? String.valueOf(model.email) :null ) : null,
                Parentesco_acompanante__pc = String.valueOf(model.relationship?.detail)
            );
        }

        public class TutorPaciente {
            Account tutor;
            Account Paciente;
            AccountContactRelation relacion;

        }
     }