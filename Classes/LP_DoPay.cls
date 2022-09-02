/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 02/08/2021
Description  : Verifies if Client is a credit client
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			02/08/2021		initial version
********************************************************************************/
public with sharing class LP_DoPay {
    
/**
*  @Description: Makes the call with Rut and dv come from a client to see if he or she is a creditclient.
*  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
*  @Date:        11/06/2021  
*/
    @AuraEnabled
    public static LP_Response doPay(String rutdv, Integer amount, String email){
        LP_Response rp = new LP_Response();
        LP_JSONPayTranRequest rq = new LP_JSONPayTranRequest();
        rq.transactionId = '';
        rq.amount = amount;
        rq.currency_x = '';
        rq.Customer = new LP_JSONPayTranRequest.Customer();
        rq.Customer.remoteId = '';
        rq.Customer.name = '';
        rq.Customer.nationalId = '';
        rq.Customer.email = email;
        rq.Customer.mobile = '';
        LP_JSONPayTranRequest.Consumptions consum = new LP_JSONPayTranRequest.Consumptions();
        consum.remoteId = '';
        consum.description = '';
        LP_JSONPayTranRequest.items items = new LP_JSONPayTranRequest.items();
        items.remoteId = '';
        items.description = '';
        items.amount = 0;
        consum.items = new List<LP_JSONPayTranRequest.items>();
        consum.items.add(items);
        rq.consumptions = new List<LP_JSONPayTranRequest.Consumptions>();
        rq.consumptions.add(consum);
        rq.usingPaymentGateway = '';
        rq.returnUserToURL = '';
        LP_PayTranCall call = new LP_PayTranCall(rq);
        String rsp = call.call().getBody();
        LP_JSONPayTranResponse aux = (LP_JSONPayTranResponse)JSON.deserialize(rsp , LP_JSONPayTranResponse.class);
        rp.URL = aux.url;
        rp.token = aux.token;
        return rp;
    }
}