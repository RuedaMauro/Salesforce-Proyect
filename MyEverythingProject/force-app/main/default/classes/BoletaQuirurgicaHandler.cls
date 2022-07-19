public with sharing class BoletaQuirurgicaHandler{

    List<BoletaModel> boletasModel = new List<BoletaModel>();
    Map<String, HealthCloudGA__EHRProcedureRequest__c> existingBoletas;
    List<HealthCloudGA__EHRProcedureRequest__c> boletas;

    public BoletaQuirurgicaHandler(List<AgendaModel> agendaModels, Map<String, HealthCloudGA__EHRProcedureRequest__c> existingBoletas) {

        this.existingBoletas = existingBoletas;
        this.boletasModel = getBoletaModels(agendaModels, existingBoletas);
    }

    public void updateMap() {
        for (HealthCloudGA__EHRProcedureRequest__c boleta : boletas)
            existingBoletas.put(boleta.HealthCloudGA__Account__r.Id_Paciente__c, boleta);
    }

    /* public List<Contact> getContacts() {

        Set<ProfessionalModel> professionalsToInsert = new Set<ProfessionalModel>();
        for (BoletaModel boletaModel : boletasModel)
            professionalsToInsert.addAll(boletaModel.getAttentionProfessionals());

        Set<String> idStaffs = new Set<String>();
        for (ProfessionalModel professionalModel : professionalsToInsert) idStaffs.add(professionalModel.id_staff);

        Map<String, Contact> contactById = ProfesionalesHandler.getContactByNumeroDeId(idStaffs);

        List<Contact> result = new List<Contact>();
        for (ProfessionalModel proModel : professionalsToInsert) {
            system.debug('ID_STAFF boleta:::' + proModel.id_staff);
            Id existingId = contactById.get(proModel.id_staff)?.Id;
            system.debug('existingID:::::::'+ existingId);
            if (existingId != null) continue;
            system.debug('proModel:::::::'+ proModel);
			system.debug('proModelIDSTAFF:::::::'+ proModel.id_staff + 'proModelDOCTYPE:::::::'+ proModel.doc_type.code);            
            result.add(ProfesionalesHandler.getProfesional(proModel.id_staff, proModel.doc_type.code));
        }

        return result;
    } */

    private List<BoletaModel> getBoletaModels(
        List<AgendaModel> agendaModels,
        Map<String, HealthCloudGA__EHRProcedureRequest__c> existingBoletas) {

        List<BoletaModel> result = new List<BoletaModel>();

        for (AgendaModel agenda : agendaModels) {

            if (agenda.id_order == null || existingBoletas.containsKey(agenda.id_patient)) continue;

            result.add(getBoletaModelFromCallout(agenda.patient.id_patient));
        }

        return result;
    }

    public void insertAttention() {

        Map<String, Id> productoIdByExternalId = getIdProductByProductCode(boletasModel);
        List<Servicio_de_Boleta_quirurgica__c> result = new List<Servicio_de_Boleta_quirurgica__c>();

        for (BoletaModel boletaModel : boletasModel) {

            if (boletaModel.attention == null || boletaModel.attention.isEmpty()) continue;

            for (BoletaModel.ServiceA att : boletaModel.attention) {

                Servicio_de_Boleta_quirurgica__c servicioBoleta = new Servicio_de_Boleta_quirurgica__c();

                servicioBoleta.Boleta_Quirurgica__c = boletaModel.boleta.Id;
                if (String.isNotBlank(att.code)){

                    servicioBoleta.Servicio__c = productoIdByExternalId.get(att.code);
                }

                /* if (String.isNotBlank(att.id_staff))
                    servicioBoleta.Profesional__r = new Contact(Numero_de_ID__c = att.id_staff); */

                result.add(servicioBoleta);
            }
        }

        insert result;
    }

    public void insertBoletas() {

        List<HealthCloudGA__EHRProcedureRequest__c> result = new List<HealthCloudGA__EHRProcedureRequest__c>();

        for (BoletaModel boletaModel : boletasModel) {

            HealthCloudGA__EHRProcedureRequest__c boleta = new HealthCloudGA__EHRProcedureRequest__c(
                HealthCloudGA__Account__r = new Account(Id_Paciente__c = boletaModel.id_patient),
                Convenio_de_paciente__c = boletaModel?.convenio?.Id);
            result.add(boleta);
            boletaModel.boleta = boleta;
        }
        insert result;
        boletas = result;
    }

    public void insertConvenios(Map<String, ID> convenioIDByCode) {
        List<Convenios_de_paciente__c> result = new List<Convenios_de_paciente__c>();

        for (BoletaModel boletaModel : boletasModel) {

            String code = boletaModel.insurance_plan?.code;
            if (code == null) continue;

            Convenios_de_paciente__c convenio = new Convenios_de_paciente__c(
                Paciente__r = new Account(Id_Paciente__c = boletaModel.id_patient),
                Convenio__c = convenioIDByCode.get(code));
            result.add(convenio);
            boletaModel.convenio = convenio;
        }

        insert result;
    }

    private Map<String, Id> getIdProductByProductCode(List<BoletaModel> boletasModel) {
        Set<String> codigoProducto = new Set<String>();
        Map<String, Id> result = new Map<String, Id>();

        for (BoletaModel boletaModel : boletasModel){
            codigoProducto.addAll(boletaModel.getAttentionCodes());
        } 

        for (Product2 producto : [SELECT Id, ProductCode FROM Product2 WHERE ProductCode  IN: codigoProducto]){
            result.put(producto.ProductCode, producto.Id);
        }

        return result;
    }

    private BoletaModel getBoletaModelFromCallout(String idPatient) {

        HttpClientFundacionSantaFe client = (HttpClientFundacionSantaFe) new HttpClientFundacionSantaFe(
            '/qx/info?pid=' + idPatient)
            .setMethod(HttpClient.Method.GET)
            .send();

        HttpResponse response = client.getResponse();
        BoletaModel result = BoletaModel.parse(response.getBody());
        return result;
    }
}