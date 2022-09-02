/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 11/06/2021
Description  : JSON response for AOE-207
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			08/06/2021		initial version
********************************************************************************/
public with sharing class LP_JSONAoe103Response {
    
    public List<Items> items;
	public String transaction_id;


	/**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Items {
		public Integer status;
		public String message;
        public String session_id;//aca
        public List<Result> result;
	}
    
    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class result {
		public String name;
		public String code;
        public String type_code;
        public String country_code;
        public String state;
        public String dateSP;
        public String end_date;
        public Integer can_sign;
        public List<can_sign_info> can_sign_info;
        public Integer security;
        public String file_preview;
        public Creator creator;
	}
    
    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class can_sign_info {
		public String role;
		public String institution;
        public Integer type;
        public String rut;
	}

    /**
    *  @Description: JSON Item section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public class Creator {
		public String name;
		public String institution;
        public String role;
        public String rut;
	}
    
    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
	public static LP_JSONAoe103Response parse(String json) {
		return (LP_JSONAoe103Response) System.JSON.deserialize(json, LP_JSONAoe103Response.class);
	}

}