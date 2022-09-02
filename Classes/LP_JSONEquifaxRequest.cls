public with sharing class LP_JSONEquifaxRequest{
    
	public LP_JSONHeaderRequest header;
	public Body body;

	public class Body {
		public Integer rut;
		public String dig;
		public String nSerie;
		//public String trans; //in JSON transaction
		public String terminal;
        public String secuence;
        public String local;
	}

	public static LP_JSONEquifaxRequest parse(String json) {
		return (LP_JSONEquifaxRequest) System.JSON.deserialize(json, LP_JSONEquifaxRequest.class);
	}
}