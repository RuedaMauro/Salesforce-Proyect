public class TutorModel {
    public String id_tutor;
    public String id_patient;
    public PatientModel patient;
    public GenericCodeModel tdoc;
    public String doc;
    public String full_name;
    public String mobile;
    public String email;
    public GenericCodeModel relationship;

    public static List<TutorModel> parse(String jsonString) {
        TutorModelResponse result = (TutorModelResponse) JSON.deserialize(jsonString, TutorModelResponse.class);
        return result.data.response;
    }

    private class TutorModelResponse {
        private Data data;
    }

    private class Data {
        private List<TutorModel> response;
    }
}