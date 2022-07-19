public class PatientModel {
    public String id_patient;
    public GenericCodeModel tdoc; // code - detail
    public GenericCodeModel doc_type;
    public String doc_number;
    public String doc;
    public String name;
    public String names;
    public String last_name;
    public String mother_last_name;
    public String paternal_surname;
    public String maternal_surname;
    public String phone;
    public String mobile;
    public String address;
    public String email;
    public String birtdate;
    public String gender;
    public GenericCodeModel country_origin;
    public String city_origin;
    public GenericCodeModel country_residence; // code - detail 
    public String city_residence;
    public GenericCodeModel civil_status;
    public String accept_habeas;

    public static List<PatientModel> parse(String jsonString) {
        PatientModelResponse result = (PatientModelResponse) JSON.deserialize(jsonString, PatientModelResponse.class);
        return result.data.response;
    }

    private class PatientModelResponse {
        private Data data;
    }

    private class Data {
        private List<PatientModel> response;
    }
}