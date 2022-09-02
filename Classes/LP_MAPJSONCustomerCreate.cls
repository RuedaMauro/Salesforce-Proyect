/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 05/07/2021
Description  : Class for Customer Create
History      : PCRM-23 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Fran Oseguera           	FO      
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      FO			5/07/2021		initial version
********************************************************************************/
public without sharing class LP_MAPJSONCustomerCreate {
    
    private LP_NacionalidadesSelector cntSelector;
    private LP_CiudadesSelector citySelector;
    private Account accRecord;
    private LP_Onboarding__c onbordingRecord;
    private LP_Nacionalidad__c cntRecord;
    private LP_Ciudad__c cityRecord;
    private Map<String, String> auditCode;
    static final string NOAPLICA = 'NO_APLICA';

    /**
    *  @Description: Constructor Method.
    *  @Autor:       FO, Deloitte, eandradea@deloitte.com
    *  @Date:        05/07/2021
    */
    public LP_MAPJSONCustomerCreate(Account record, LP_Onboarding__c onb, Map<String, String> auditCodes) {
        this.accRecord = record;
        this.onbordingRecord = onb;
        this.cntSelector = new LP_NacionalidadesSelector();
        this.cntRecord = cntSelector.selectByIdWithLimit(accRecord.LP_Nacionalidad__pc);
        this.citySelector = new LP_CiudadesSelector();
        this.cityRecord = citySelector.selectByIdWithLimit(accRecord.LP_Ciudad__pc);
        this.auditCode = auditCodes;
    }

    /**
    *  @Description: Mapping method.
    *  @Autor:       FO, Deloitte, eandradea@deloitte.com
    *  @Date:        05/07/2021
    */
    public LP_JSONCustomerCreateRequest mapping(){
        LP_JSONCustomerCreateRequest client = new LP_JSONCustomerCreateRequest();        
        client.body = new LP_JSONCustomerCreateRequest.Body();
        client.body.NumRut = Integer.valueOf(accRecord.Vass_Rut__c.split('-')[0]); 
        client.body.DIGRUT = accRecord.Vass_Rut__c.split('-')[1];
        client.body.TIPCLIEN = '01'; //DEFAULT
        client.body.LIMCRECTA1IMP = string.valueOf(accRecord.LP_CupoDisponible__pc);
        client.body.NOMBENREDTAR = accRecord.FirstName + ' ' + accRecord.LastName + ' ' + accRecord.LP_ApellidoMaterno__pc;
        client.body.POBLACION = accRecord.PersonMailingCity;
        client.body.GRUPOLIQ = accRecord.LP_FechaPago__pc;
        client.body.NOMBRE = accRecord.FirstName;
        client.body.PRODUCTO = accRecord.LP_TipoTarjeta__pc;
        client.body.SUBPRODU = accRecord.LP_TipoTarjeta__pc == '01' ? '0001' : '0003';
        client.body.INDESTCIV = '1'; //DEFAULT
        client.body.DESCLAVE4 = accRecord.PersonMobilePhone.replace('+','');
        client.body.TIPVIA = 'CL'; //DEFAULT
        client.body.CODPROF = '799'; //DEFAULT
        client.body.NUMVIA = toString(accRecord.LP_NumDeptoCasa__pc);
        client.body.CONPROD = accRecord.LP_TipoTarjeta__pc == '01' ? '047' : '017'; //DEFAULT
        client.body.FECINIL1 = datetime.now().format('dd-MM-yyyy'); //DEFAULT
        client.body.CODPROV = accRecord.PersonMailingCity; //city 
        client.body.FECCADTAR = ''; //DEFAULT
        //client.body.FECINIL3 = datetime.now().format('dd-MM-yyyy'); //DEFAULT
        //client.body.FECINIL2 = datetime.now().format('dd-MM-yyyy'); //DEFAULT
        client.body.CALPARTTAR = 'TI'; //DEFAULT
        client.body.NUMDOC = accRecord.Vass_Rut__c;
        client.body.APELLI2 = accRecord.LastName;
        client.body.APELLI1 = accRecord.LP_ApellidoMaterno__pc;
        client.body.SEXPER = accRecord.LP_Genero__pc == 'Masculino' ? 'V' : 'M';
        client.body.NOMVIA = accRecord.PersonMailingStreet;
        client.body.FECNAC = birthDateFormat(onbordingRecord.LP_FechaNacimiento__c);
        client.body.GRUPOCUO = accRecord.LP_FechaPago__pc; 
        client.body.CODREGIMEN = '1'; //DEFAULT
        client.body.LIMCRELINL3 = '0'; //DEFAULT
        client.body.RESTODIR = accRecord.PersonMailingStreet + ' ' + accRecord.LP_NumDeptoCasa__pc; //accRecord.Street + ' ' + accRecord.LP_NumDeptoCasa__pc; // La longitud máxima del campo body.RESTODIR es 40
        client.body.LIMCRELINL1 = '0'; //DEFAULT
        client.body.CODENT = '0697'; //DEFAULT
        client.body.CODREGION = accRecord.PersonMailingState; // 'Región Metropolitana'; //accRecord.State; // Región obtenida de API de autocompletado de dirección '005'
        client.body.LIMCRELINL2 = '0'; //DEFAULT
        client.body.PANASOCTAR = ''; //DEFAULT
        client.body.NOMBREEMP = ''; //DEFAULT VACIO
        client.body.CENTALTA = '0022'; //DEFAULT
        client.body.p_desgra = 0;
        client.body.p_cesant = 0;
        client.body.p_diapag = accRecord.LP_FechaPago__pc != null ? integer.valueOf(accRecord.LP_FechaPago__pc) : 5;
        client.body.CEDULASERIE = '01'; //Número de serie obtenido por servicio de Validación Biométrica de Jumio
        client.body.p_compar = accRecord.PersonMailingCity;//city; //Comuna obtenida de api de autocompletado de dirección
        client.body.p_local = 22; //DEFAULT
        client.body.p_rutcap = 11111111; //DEFAULT
        client.body.p_digcap = '1'; //DEFAULT
        client.body.p_item_contrato = '0000'; //onbordingRecord.LP_CodigoContratoApertura__c; //'01'; // Nombre de contrato (obtenido por servicio de Autentia)
        client.body.p_num_contrato = onbordingRecord.LP_CodigoContratoApertura__c; //onbordingRecord.LP_CodigoConstanciaSuscripcion__c; // '01'; // Código de contrato (terminado en pdf) (obtenido por servicio de Autentia)
        client.body.p_cod_aut = auditCode.get(onbordingRecord.LP_CodigoContratoApertura__c); //onbordingRecord.LP_CodigoAutorizacionEspecial__c; //'01'; // Código de autorización/auditoría (obtenido por servicio de Autentia)
        client.body.p_num_mandato = onbordingRecord.LP_CodigoMandato__c; // '01'; // Código de Mandato (terminado en pdf) (obtenido por servicio de Autentia)
        client.body.p_num_resumen = onbordingRecord.LP_CodigoResumenContratoApertura__c; // '01';  // Código de Resumen (terminado en pdf) (obtenido por servicio de Autentia)
        client.body.p_cod_autman = auditCode.get(onbordingRecord.LP_CodigoMandato__c); //NOAPLICA; // No aplica autorización manual, campo vacío
        client.body.p_cod_autres = auditCode.get(onbordingRecord.LP_CodigoResumenContratoApertura__c);//'01'; // Código de auditoría (obtenido por servicio de Autentia) Resumen contrato de apertura
        client.body.p_num_consenti = onbordingRecord.LP_CodigoAutorizacionEspecial__c; //NOAPLICA; // Número de Consentimiento (terminado en pdf) (obtenido por servicio de Autentia) en onboarding no se está utilizando
        client.body.p_cod_consenti = auditCode.get(onbordingRecord.LP_CodigoAutorizacionEspecial__c);//NOAPLICA; // Código de auditoria Consentimiento (terminado en pdf) (obtenido por servicio de Autentia) en onboarding no se está utilizando
        client.body.p_num_anexo1 = NOAPLICA; // Número de Anexo 1 (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_num_anexo2 = NOAPLICA; // Número de Anexo 2 (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_num_anexo3 = onbordingRecord.LP_CodigoConstanciaSuscripcion__c; //NOAPLICA; // Número de Anexo 3 (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_num_solren = NOAPLICA; // Número de Solicitud (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_cod_autsre = NOAPLICA; // Código de auditoría (obtenido por servicio de Autentia) - No Aplica
        client.body.p_num_solcyt = NOAPLICA; // (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_cod_autcyt = NOAPLICA; // Código de auditoría (obtenido por servicio de Autentia) - No Aplica
        client.body.p_num_solcrt = NOAPLICA; // (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_cod_autcrt = NOAPLICA; // Código de auditoría (obtenido por servicio de Autentia) - No Aplica
        client.body.p_rutsecu = 0; //DEFAULT
        client.body.p_item_canal = '0900'; //DEFAULT
        client.body.p_num_fip = NOAPLICA; // (terminado en pdf) (obtenido por servicio de Autentia) - No Aplica
        client.body.p_cod_fip = NOAPLICA; // Código de auditoría (obtenido por servicio de Autentia) - No Aplica
        client.body.p_tipo_tarjeta = accRecord.LP_TipoTarjeta__pc == '01' ? 'TLPSAT' : 'VISA';
        client.body.in_posesion = '1'; //DEFAULT
        client.body.MAIL = accRecord.PersonEmail;
        client.body.TIPOVIVIENDA = 'DEPTO'; // No acepta null;
        client.body.CELULAR = accRecord.PersonMobilePhone;
        client.body.CODCEL = '9';
        client.body.nacionalidad = cntRecord.Name; //accRecord.LP_Nacionalidad__c; //hay que hacer una query. 
        //campos agregados mejora PCRM-1081
        client.body.condesttar = accRecord.LP_TipoTarjeta__pc == '01' ? '001' : '003';
        client.body.tipo_eleccion = 'direccion_postal_eecc';
        client.body.subtipo_eleccion = accRecord.LP_EstadoCuentaMail__pc == true ? 'email_personal' : 'fisica_personal';
        client.body.valor_eleccion = '0'; 
        client.body.canal_origen = 'creditmaker'; 

        // variables heredadas del servicio 940.
        client.body.personal_direccion_referencia =  client.body.RESTODIR;
        client.body.p_fecnac = client.body.FECNAC;
        client.body.dirpar = accRecord.PersonMailingStreet;//accRecord.Street; // La longitud máxima del campo body.dirpar es 40
        client.body.in_titular_rut = client.body.NumRut;
        client.body.in_titular_dv = client.body.DIGRUT;
        client.body.in_tarjeta_cod = client.body.PRODUCTO;
        client.body.in_fecha_emision =  datetime.now().format('dd-MM-yyyy');

        client.header = new LP_JSONHeaderRequest();
        client.header.country = 'CL';
        client.header.commerce = 'RF';
        client.header.channel = 'CRM';
        client.header.operation = 'string';
        client.header.storeId = 'string';
        client.header.terminalId = 'string';
        return client;

    }

    /**
    *  @Description: Get Liquidation Group
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private String codLiquidationGroup(String day) {
        Map<String, String> dayMap = new Map<String, String>();
        dayMap.put('1', '0');
        dayMap.put('5', '1');
        dayMap.put('10', '2');
        dayMap.put('15', '3');
        dayMap.put('20', '4');
        dayMap.put('25', '5');
        return dayMap.get(day);
    }

    /**
    *  @Description: Get the mapping of Document Five "OTP"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private String toString(Object str) {
        String res = str != Null ? String.valueOf(str) : '';
        return res;
    }

    /**
    *  @Description: Get the mapping of Document Five "OTP"
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    private String birthDateFormat(date btDate) {
        String str = '';
        if (btDate != null) {
            Time myTime = Time.newInstance(3, 3, 3, 0);
            DateTime birthDate =  DateTime.newInstance(btDate, myTime);
            str = birthDate.format('dd-MM-yyyy');
        }
        return str;
    }

    /**
    *  @Description: Call service with token.
    *  @Autor:       FO, Deloitte
    *  @Date:        05/07/2021
    */
    public string call(){

        Map<String, String> pathParam = new Map<String, String>();
        Map<String, String> mapHeader = new Map<String, String>();
        Map<String, String> mapQuery = new Map<String, String>();
        Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
        setConf.put('header', mapHeader);
        setConf.put('path', pathParam);
        setConf.put('query', mapQuery);
        LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth('URL_Base_Integracion', 'CreacionDeCliente');
        String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }
}