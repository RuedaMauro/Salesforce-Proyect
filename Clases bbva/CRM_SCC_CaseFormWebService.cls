@RestResource(urlMapping='/cases/forms')
global with sharing class CRM_SCC_CaseFormWebService {

    @HttpPost
    global static void doPostMethod(){
        RestRequest req;
        RestResponse res;
        String jsonPayLoad;

        try{
            req = RestContext.request;
            res = RestContext.response;
            jsonPayLoad = req.requestBody.toString();

            CRM_SCC_Form baseForm = (CRM_SCC_Form) System.JSON.deserialize(jsonPayLoad, CRM_SCC_Form.class);
            CRM_CaseService.FormResponse formResponse;

            System.debug('Request body: ' + baseForm);
            System.debug('Request body: ' + baseForm.isValid());

            if(baseForm.isValid() && String.isNotEmpty(jsonPayLoad)){
                Boolean isPublic = (baseForm.source == 'Formulario Público');
                Boolean isPrivate = (baseForm.source == 'Formulario Privado');

                if(isPublic){
                    formResponse = CRM_CaseService.createPublicForm(baseForm);
                }
                if(isPrivate){
                    CRM_SCC_Form privateForm = (CRM_SCC_Form) System.JSON.deserialize(jsonPayLoad, CRM_SCC_Form.class);

                    formResponse = CRM_CaseService.createPrivateForm(privateForm);
                }
            } else{
                formResponse = new CRM_CaseService.FormResponse();
                formResponse.caseId = null;
                formResponse.status = 'NOK';
                formResponse.message = 'Faltan campos obligatorios';
            }

            res.responseBody = Blob.valueOf(JSON.serialize(formResponse));

            if(formResponse.status == 'OK'){
                res.statusCode = HttpStatusCodes.OK;
            } else {
                res.statusCode = HttpStatusCodes.BAD_REQUEST;
            }
        } catch(Exception e){
            System.debug('Form web service error: ' + e.getMessage() + '\n' + e.getLineNumber());
        }
    }
}