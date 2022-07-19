public class EventoModel {
    public String id_patient; 
    public PatientModel patient;   
    public String id_staff;
    public ProfessionalModel staff;  
    public String id_tutor;
    public TutorModel tutor; 
    public List<Diagnostico> diagnostics; 
    public String start_date;      
    public String start_hour;
    public String allergies;
    public String alerts;
    public String reason;
    public String inability;
    public String patient_invoiced_value;        
    public String insurance_invoiced_value;   
    public String indications;   
    public String prescription; 
    public String event_number; 
    public String records;  

    public String physical_exam; 
    public String progress; 
    public GenericCodeModel ambit; 
	public String last_page;
    
    public class Diagnostico {
        public string code;
    }

    public class Allergies {
        public ProfessionalModel staff;
        public String detail;
        public String datee;
        public String hour;
    }

    public class IncapacidadesGeneric {
        public String type;
    } 

    public class Progress {
        public String prescription;
    }

    public static List<EventoModel> parse(String jsonString) {
        EventoModelResponse result = (EventoModelResponse) JSON.deserialize(jsonString, EventoModelResponse.class);
        return result.data.response;
    }

    public static EventoPagination parsePagination(String jsonString) {
        EventoModelResponse result = (EventoModelResponse) JSON.deserialize(jsonString, EventoModelResponse.class);
        return result.data.pagination;
    }
    
    private class EventoModelResponse {
        private Data data;
    }

    public class EventoPagination {
        public Integer total;
		public Integer last_page;
		public Integer page;
    }

    
    private class Data {
        private EventoPagination pagination;
        private List<EventoModel> response;
    }
}