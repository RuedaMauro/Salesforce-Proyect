/*
 * En esta clase se encuentran los atributos a los que hacen referencia al mapeo de datos del JSON,
 * con el servicio de agenda.
 * @param args[].
 * @return void.
*/
public class AgendaModel {
    public String id_patient;
    public PatientModel patient;
    public GenericCodeModel insurance_plan;
    public String id_staff;
    public ProfessionalModel staff;
    public String form_number;
    public String id_order; // ID Boleta
    public BoletaModel boleta;         
    public GenericCodeModel status;
    public String date_appoinment;
    public String hour_appoinment;
    public Location location;
    public GenericCodeModel specialty;
    public GenericCodeModel sub_specialty;
    public GenericCodeModel service;
    public Attention attention;
    public String last_page;
	
 /*
  * Clase anidada con el objeto localizacion
  * @param args[].
  * @return void.
  */	    
    public class Location {
        public String code;
        public String detail;
        public Building building;
    }

  /*
   * Clase anidada con el objeto servicio
   * @param args[].
   * @return void.
   */	        
    public class Attention {
        public String code;
        public String detail;
        public String cost;
        public GenericCodeModel type;
    }
    
  /*
   * Clase anidada con el objeto sede
   * @param args[].
   * @return void.
   */
    public class Building{
        public String code;
        public String detail;
        public GenericCodeModel city;
        public String Address; 
    }
 
  /*
   * Clase anidada estatica, que tiene como parametro una cadena de JSON, su funcion es la de deserializar
   * la cadena JSON y guardarlo en el objeto AgendaModelResponse.   
   * @return result.data.response;.
   * @param args[String jsonString].
   */
    public static List<AgendaModel> parse(String jsonString) {
        AgendaModelResponse result = (AgendaModelResponse) JSON.deserialize(jsonString, AgendaModelResponse.class);
        return result.data.response;
    }

    
  /*
   * Clase anidada estatica, que tiene como parametro una cadena de JSON, su funcion es la de deserializar
   * la cadena JSON y guardarlo en el objeto AgendaModelResponse, y retorna el objeto pagination para poder usarlo
   * y iniciar el paginado.   
   * @return return result.data.pagination;.
   * @param args[String jsonString].
   */    
    public static AgendaPagination parsePagination(String jsonString) {
        AgendaModelResponse result = (AgendaModelResponse) JSON.deserialize(jsonString, AgendaModelResponse.class);
        return result.data.pagination;
    }

    /*
   * Clase privada, contiene el atributo data    
   * @return .
   * @param args[].
   */    
    private class AgendaModelResponse {
        private Data data;
     //   private Pagination pagination;
    }
    
    
  /*
   * Clase con atributos, que hacen referencia a los campos de paginatation en la cadena del JSON del servicio de agenda    
   * @return.
   * @param args[].
   */
    public class AgendaPagination {
        public Integer total;
		public Integer last_page;
		public Integer page;
    }
    
  /*
   * Clase con atributos, que hacen referencia a la data del JSON del servicio de agenda    
   * @return.
   * @param args[].
   */
    private class Data {
        private AgendaPagination pagination;
        private List<AgendaModel> response;
    }
}