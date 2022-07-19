public with sharing class BoletaModel {

    public String id_patient;
    public PatientModel patient;
    public String id_order;
    public GenericCodeModel insurance_plan;// has type?
    public List<ServiceA> attention;
    public String resources;
    public String order_code;
    public Integer event_code;
    public Qx qx;
    public GenericCodeModel stage;
    public GenericCodeModel anesthesia;
    public GenericCodeModel ambit;
    public Boolean icu;
    public HealthCloudGA__EHRProcedureRequest__c boleta;
    public Convenios_de_paciente__c convenio;
    public ServiceAppointment servApp;

    public class ServiceA {
        public String code;
        public String detail;
        public String id_staff;
        public ProfessionalModel staff;
    }

    public Set<String> getAttentionCodes() {
        Set<String> result = new Set<String>();

        if (this.attention == null || this.attention.isEmpty()) return result;

        for (ServiceA att : attention) result.add(att.code);

        return result;
    }

    public Set<String> getAttentionProfessionals() {

        Set<String> result = new Set<String>();

        if (this.attention == null || this.attention.isEmpty()) return result;

        for (ServiceA att : attention)
        {
            att.staff.id_staff = att.id_staff;
            result.add(att.id_staff);
        }
        return result;
    }

    public class Qx {
        public String proposed_duration;
        public Integer qx_days;
        public String qx_date;
        public String qx_hour;
        public String qx_room;
    }

    public static BoletaModel parse(String jsonString) {
        BoletaModelResponses result = (BoletaModelResponses) JSON.deserialize(jsonString, BoletaModelResponses.class);
        return (result.data.response[0]);
    }

    private class BoletaModelResponses {
        private Data data;
    }

    private class Data {
        private List<BoletaModel> response;
    }
}