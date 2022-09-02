/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 28/07/2021
Description  : JSON request for Pay transaction
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			28/07/2021		initial version
********************************************************************************/
public with sharing class LP_JSONPayTranRequest {
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        12/08/2021
    */
    private static final String CURRENCY_X_ST;
    private static final String USING_GATEWAY;
    
    static{
    	CURRENCY_X_ST = 'CLP';
        USING_GATEWAY = 'UNIRED_BP';
    }
    
	public String transactionId;
    public Integer amount;
	public String currency_x;
    public Customer customer;
    public List<Consumptions> consumptions;
	public String usingPaymentGateway;
    public String returnUserToURL;
    
    /**
    *  @Description: Constructor
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public LP_JSONPayTranRequest() {
        this.currency_x = CURRENCY_X_ST;
    	this.usingPaymentGateway = USING_GATEWAY;
        this.returnUserToURL = [SELECT Return_Url__c  FROM OSF_Endpoints__mdt].Return_Url__c;
        this.Customer = new LP_JSONPayTranRequest.Customer();
        this.consumptions = new List<LP_JSONPayTranRequest.Consumptions>();
    }
    
    /**
    *  @Description: JSON Customer section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class Customer {
		public String remoteId;
		public String name;
		public String nationalId;
        public String email;
        public String mobile;
	}
    
    /**
    *  @Description: JSON Cunsumptions section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class Consumptions {
		public String remoteId;
		public String description;
		public List<items> items;
	}
    
    /**
    *  @Description: JSON Items section
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        11/06/2021
    */
    public class items {
		public String remoteId;
		public String description;
		public Integer amount;
	}

    /**
    *  @Description: parse method
    *  @Autor:       DAB, Deloitte, dbiaggio@deloitte.com
    *  @Date:        08/06/2021
    */
	public static LP_JSONPayTranRequest parse(String json) {
		return (LP_JSONPayTranRequest) System.JSON.deserialize(json, LP_JSONPayTranRequest.class);
	}
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    public static String serialize(String json) {
        Map<String, String> replacements = new Map<String, String> {
            'currency_x' => 'currency'
        };
        return mogrifyJSON(json, replacements);
    }
    
    public static String mogrifyJSON(String data, Map<String, String> replacements) {
        // Regex to match the start of the line and the key
        // surrounded by quotes and ending with a colon
        String regexFormat = '(?m)^\\s*"{0}"\\s*:';

        // Replacement format of the new key surrounded by
        // quotes and ending with a colon
        String replacementFormat = '"{0}" :';

        // A map of existing key to replacement key


        // Since our JSON can come in formatted however the
        // endpoint wants, we need to format it to a standard
        // we know and can handle
        String formattedJSON = JSON.serializePretty(JSON.deserializeUntyped(data));

        // Iterate over all the keys we want to replace
        for (String key : replacements.keySet()) {
            // Generate our regex based on the key
            String regex = String.format(regexFormat, new List<String> { key });

            // Generate our replacement
            String replacement = String.format(replacementFormat, new List<String> { replacements.get(key) });

            // Find all and replace
            formattedJSON = formattedJSON.replaceAll(regex, replacement);
        }
        return formattedJSON;
    }
    
    
    
}