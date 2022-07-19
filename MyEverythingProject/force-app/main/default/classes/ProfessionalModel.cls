public class ProfessionalModel {
    public String id_staff;
    public GenericCodeModel doc_type;
    public String name;
    public String paternal_surname;
    public String maternal_surname; 
    public String mobile;
    public String email;
    public GenericCodeModel specialty;
    public GenericCodeModel sub_specialty;

    public static List<ProfessionalModel> parse(String jsonString) {
        ProfessionalModelResponse result = (ProfessionalModelResponse) JSON.deserialize(jsonString, ProfessionalModelResponse.class);
        system.debug('DebugProfessional:::::'+ result.data.response);
        return result.data.response;
    }

    private class ProfessionalModelResponse {
        private Data data;
    }

    private class Data {
        private List<ProfessionalModel> response;
    }
}