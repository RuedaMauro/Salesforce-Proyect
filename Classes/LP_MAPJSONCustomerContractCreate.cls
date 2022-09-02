/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/07/2021
Description  : Class for Customer Contract Create Service mapping
History      : PCRM-20 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA		08/07/2021	initial version
********************************************************************************/
public inherited sharing class LP_MAPJSONCustomerContractCreate {

    private List<LP_ConfiguracionDocumentos__mdt> documents;
    private LP_BasesExpressSelector baseExpressSelector;
    private LP_Base_Express__c bsexp;
    private Lead lead;
    private LP_Onboarding__c onb;
    private String fullName;
    public Boolean isVisa = false;

    public LP_MAPJSONCustomerContractCreate(List<LP_ConfiguracionDocumentos__mdt> docs, Lead lead, LP_Onboarding__c onb) {
        this.documents = docs;
        this.lead = lead;
        this.onb = onb;
        this.fullName = toString(lead.FirstName) + ' ' + toString(lead.LastName) + ' ' + toString(lead.LP_ApellidoMaterno__c);
        this.isVisa = lead.LP_TipoTarjeta__c == LP_OnBoardingUtility.PBC_API_TLPVISA ? true : false;
        this.baseExpressSelector = new LP_BasesExpressSelector();
        this.bsexp = baseExpressSelector.selectByRutWithLimit(lead.LP_Rut__c);
    }
    
    /**
    *  @Description: Mapping method.
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private List<LP_JSONCustomerContractCreateRequest> mapping(){

        List<LP_JSONCustomerContractCreateRequest> docList = new List<LP_JSONCustomerContractCreateRequest>();
        Map<String, Map<String, String>> mapDocuments = getDocuments();

        for (LP_ConfiguracionDocumentos__mdt eachDoc : documents) {
            LP_JSONCustomerContractCreateRequest doc = new LP_JSONCustomerContractCreateRequest();
            doc.header = new LP_JSONHeaderRequest();
            doc.header.country = 'CL';
            doc.header.commerce = 'RF';
            doc.header.channel = 'Omnichannel';

            doc.body = new LP_JSONCustomerContractCreateRequest.Body();
            doc.body.tipoContrato = Integer.valueOf(eachDoc.LP_Id__c);
            doc.body.rut = Integer.valueOf(lead.LP_Rut__c.split('-')[0]);
            doc.body.dv = lead.LP_Rut__c.split('-')[1];
            doc.body.categoria = Integer.valueOf(bsexp.LP_TipoCliente__c);
            doc.body.cupo = Integer.valueOf(bsexp.LP_Cupo__c);
            doc.body.type_code = eachDoc.LP_CodigoDeDocumento__c;
            doc.body.institution = eachDoc.LP_Institucion__c;
            doc.body.name =  lead.LP_Rut__c + ' ' + eachDoc.LP_Id__c + '-' + eachDoc.MasterLabel;
            doc.body.signers_roles = new List<String>{lead.LP_Rut__c, eachDoc.LP_RolDelFirmante__c};
            doc.body.signers_institutions = new List<String>{lead.LP_Rut__c, eachDoc.LP_Institucion__c};
            doc.body.signers_emails = new List<String>{lead.Email, eachDoc.LP_CorreoInstitucion__c};
            doc.body.signers_ruts = new List<String>{lead.LP_Rut__c, eachDoc.LP_RUTInstitucion__c};
            doc.body.signers_type = new List<Integer>{0, Integer.valueOf(eachDoc.LP_TipoDefirmante__c)};
            doc.body.signers_order = new List<Integer>{1, Integer.valueOf(eachDoc.LP_Orden__c)};
            doc.body.signers_notify = new List<Integer>{2, 0};
            doc.body.tags = new List<String>{'TAG1', 'TAG2'};
            doc.body.field_tags = new List<String>(mapDocuments.get(eachDoc.MasterLabel).keySet());
            doc.body.field_tags_values = mapDocuments.get(eachDoc.MasterLabel).values();
            doc.body.comment = '';
            doc.body.file = '0';
            doc.body.file_mime = 'application/pdf';
            docList.add(doc);
        }
        mapDocuments.clear();
        return docList;
    }

    /**
    *  @Description: Get the mapping of all documents
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, Map<String, String>> getDocuments(){
        Map<String, Map<String, String>> docTlp = new Map<String, Map<String, String>>();
        docTlp.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCONE, getDocumentOne());
        docTlp.put(isVisa ? LP_OnBoardingUtility.PBC_STR_NAMEDOCTWOVISA : LP_OnBoardingUtility.PBC_STR_NAMEDOCTWO, getDocumentTwo());
        docTlp.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCTHREE, getDocumentThree());
        docTlp.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCFOUR, getDocumentFour());
        docTlp.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCFIVE, getDocumentFive());
        return docTlp;
    }

    /**
    *  @Description: Get the mapping of Document One "Autorización Especial"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, String> getDocumentOne(){
        Map<String, String> docOne = new Map<String, String>();
        // docOne.put('OTP', toString(onb.LP_CodigoOTP__c)); It is eliminated
        docOne.put('Celular', toString(lead.MobilePhone));
        docOne.put('Ciudad', toString(lead.City)); // Does not exist
        docOne.put('Dia', toString(system.now().day()));
        docOne.put('Mes', getMonth(system.now().month()));
        docOne.put('Annio', String.valueOf(system.now().format('YY')));
        return docOne;
    }

    /**
    *  @Description: Get the mapping of Document Two "Contrato Apertura"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, String> getDocumentTwo(){
        Map<String, String> docTwo = new Map<String, String>();
        String cupoTotal = (lead.LP_CupoDisponible__c != null)? String.valueOf(lead.LP_CupoDisponible__c.format()) : String.valueOf(lead.LP_CupoDisponible__c);
        docTwo.put('FV_5', toString(lead.LP_FechaPago__c) == '5' ? 'on' : 'off');
        docTwo.put('FV_10', toString(lead.LP_FechaPago__c) == '10' ? 'on' : 'off');
        docTwo.put('FV_15', toString(lead.LP_FechaPago__c) == '15' ? 'on' : 'off');
        docTwo.put('FV_20', toString(lead.LP_FechaPago__c) == '20' ? 'on' : 'off');
        docTwo.put('FV_25', toString(lead.LP_FechaPago__c) == '25' ? 'on' : 'off');
        docTwo.put('FV_30', toString(lead.LP_FechaPago__c) == '30' ? 'on' : 'off');
        docTwo.put('Cupo_Total_Autorizado', cupoTotal);
        docTwo.put('Nombre_Titular', fullName);
        docTwo.put('Rut_Titular', toString(lead.LP_Rut__c));
        docTwo.put('Telefono_Particular_Titular', toString(lead.MobilePhone));
        docTwo.put('Telefono_Celular_Titular', toString(lead.MobilePhone));
        docTwo.put('Domicilio_Titular', toString(lead.Street));
        docTwo.put('Ciudad_Titular', toString(lead.City)); // Does not exist
        docTwo.put('Comuna_Titular', toString(lead.City));
        docTwo.put('email_Titular', toString(lead.Email));
        //docTwo.put('OTP_1', toString(onb.LP_CodigoOTP__c)); It is eliminated
        docTwo.put('Celular_1', toString(lead.MobilePhone));
        docTwo.put('Ciudad_1', toString(lead.City)); // Does not exist
        docTwo.put('Dia_1', toString(system.now().day()));
        docTwo.put('Mes_1', getMonth(system.now().month()));
        docTwo.put('Annio_1', String.valueOf(system.now().format('YY')));
        //docTwo.put('OTP_2', toString(onb.LP_CodigoOTP__c)); It is eliminated
        docTwo.put('Celular_2', toString(lead.MobilePhone));
        docTwo.put('Ciudad_2', toString(lead.City)); // Does not exist
        docTwo.put('Dia_2', toString(system.now().day()));
        docTwo.put('Mes_2', getMonth(system.now().month()));
        docTwo.put('Annio_2', String.valueOf(system.now().format('YY')));
        return docTwo;
    }

    /**
    *  @Description: Get the mapping of Document Three "Mandato"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, String> getDocumentThree(){
        Map<String, String> docThree = new Map<String, String>();
        docThree.put('Nombre_Titular', fullName);
        docThree.put('Rut_Titular', toString(lead.LP_Rut__c));
        docThree.put('Ciudad_Titular', toString(lead.City)); // Does not exist
        docThree.put('Comuna_Titular', toString(lead.City));
        docThree.put('Domicilio_Titular', toString(lead.Street));
        getParamsTLP(docThree);
        //docThree.put('OTP', toString(onb.LP_CodigoOTP__c)); It is eliminated
        docThree.put('Celular', toString(lead.MobilePhone));
        docThree.put('Ciudad', toString(lead.City)); // Does not exist
        docThree.put('Dia', toString(system.now().day()));
        docThree.put('Mes', getMonth(system.now().month()));
        docThree.put('Annio', String.valueOf(system.now().format('YY')));
        return docThree;
    }

    /**
    *  @Description: Get the mapping of Document Four "Resumen Contrato Apertura"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, String> getDocumentFour(){
        Map<String, String> docFour = new Map<String, String>();
        String cupoTotal = (lead.LP_CupoDisponible__c != null)? String.valueOf(lead.LP_CupoDisponible__c.format()) : String.valueOf(lead.LP_CupoDisponible__c);
        docFour.put('Nombre_Titular', fullName);
        docFour.put('Rut_Titular', toString(lead.LP_Rut__c));
        docFour.put('Fecha', Date.today().format());
        docFour.put('Cupo_Total', cupoTotal);
        getParamsTLP(docFour);
        //docFour.put('OTP', toString(onb.LP_CodigoOTP__c)); It is eliminated
        docFour.put('Celular', toString(lead.MobilePhone));
        docFour.put('Ciudad', toString(lead.City)); // Does not exist
        docFour.put('Dia', toString(system.now().day()));
        docFour.put('Mes', getMonth(system.now().month()));
        docFour.put('Annio', String.valueOf(system.now().format('YY')));
        return docFour;
    }

    /**
    *  @Description: Get the mapping of Document Five "Constancia De Suscripcion Onboarding"
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        19/07/2021
    */
    private Map<String, String> getDocumentFive(){
        Map<String, String> docFive = new Map<String, String>();
        docFive.put('Nombre_Titular', fullName);
        docFive.put('Rut_Titular', toString(lead.LP_Rut__c));
        docFive.put('Fecha', Date.today().format());
        docFive.put('OTP', toString(onb.LP_CodigoOTP__c));
        docFive.put('Celular', toString(lead.MobilePhone));
        return docFive;
    }

    /**
    *  @Description: Get the mapping of params TLP
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private Map<String, String> getParamsTLP(Map<String, String> param){
        if (!isVisa) {
            param.put('Plazo_Vigencia_Tarjeta','');
        }
        return param;
    }

    /**
    *  @Description: Get the mapping of Document Five "OTP"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private String toString(Object str){
        String res = str != Null ? String.valueOf(str) : '';
        return res;
    }

    private String getMonth(Integer mes){
        Map<Integer, String> meses = new Map<Integer, String>();
        meses.put(1,'Enero');
        meses.put(2,'Febrero');
        meses.put(3,'Marzo');
        meses.put(4,'Abril');
        meses.put(5,'Mayo');
        meses.put(6,'Junio');
        meses.put(7,'Julio');
        meses.put(8,'Agosto');
        meses.put(9,'Septiembre');
        meses.put(10,'Octubre');
        meses.put(11,'Noviembre');
        meses.put(12,'Diciembre');
    return meses.get(mes);
    }

    /**
    *  @Description: Call service with token.
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    public Map<String, String> call(){
        String rsp;
        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'CreacionDeDocumentos');
        Map<String, String> response = new Map<String, String>();
        Integer i = 0;
        for (LP_JSONCustomerContractCreateRequest eachDoc : mapping()) {
            response.put(documents.get(i).MasterLabel, objClass.callServiceWithToken(setConf, JSON.serialize(eachDoc, true)).getBody());
            i++;
        }        
        return response;
    }
}