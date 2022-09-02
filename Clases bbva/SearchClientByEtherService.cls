/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-16-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class SearchClientByEtherService {
   
    public class AccountsFields{  
        public String id;
        public String name;
        public String last_name;
        public String doc_number;
        public String documentType;
        public String phone;
        public String birthdate;
        public String email;
    }
    public static void returnJsonClient() {
     //   return (SearchClientByEtherService) System.JSON.deserialize(json, SearchClientByEtherService.class);
    
    }

    //public static List<SearchClientByEtherService> getClient() {

        //return AgendaModel.parse(getClientsResponse());
   // }
    
   // public static String getClientsResponse() {
/*
        HttpClient client = (HttpClient) new HttpClient(
            ETHER_NAMED_CREDENTIAL, 'dddoc' + String.valueOf(today.addDays(-4)))
            .setMethod(HttpClient.Method.GET)
            .setTimeOut(120000)
            .send();

        HttpResponse response = client.getResponse();
        return response.getBody();
  */
    //}


    public static List<SearchClientByEtherService> parse(string jsonString) {
        EtherServiceModelResponse result = (EtherServiceModelResponse) JSON.deserialize(jsonString, EtherServiceModelResponse.class);
        return result.data.response;
    }
    private class EtherServiceModelResponse {
        private Data data;
    }
    private class Data {
        private List<SearchClientByEtherService> response;
    }

}
