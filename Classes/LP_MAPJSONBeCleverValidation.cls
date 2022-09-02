/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Class for JSON BeClever validation mapping
History      : PCRM-19
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Alan Sanhueza Carrasco	     ASC
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       ASC        08/06/2021		  initial version
********************************************************************************/
public with sharing class LP_MAPJSONBeCleverValidation {
    
    Private static final String PRV_URL_BASEURL;
    private static final String PRV_SRV_BECLEVER;
    private SObject record;
    private String azurianToken;

    static {
        PRV_URL_BASEURL = 'URL_Base_Integracion';
        PRV_SRV_BECLEVER = 'ValidacionBeClever';     
    }
    
	/**
    *  @Description: Constructor
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
    public LP_MAPJSONBeCleverValidation(SObject rec, String token) {
        this.record = rec;
        this.azurianToken = token;
    }
      
    /**
    *  @Description: BeClever validation json mapping
    *  @Author:      ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
    public LP_JSONBeCleverRequest mapping(){
		Lead leadRecord = (Lead)this.record;
        LP_JSONBeCleverRequest reqBeClever = new LP_JSONBeCleverRequest();
        reqBeClever.body = new LP_JSONBeCleverRequest.Body();
        reqBeClever.body.idsistema = 36;
        reqBeClever.body.idflujo = 3;
        LP_Base_Express__c obj = new LP_Base_Express__c();
        LP_BasesExpressSelector objSelector = new LP_BasesExpressSelector();
        obj = objSelector.selectByRutWithLimit(leadRecord.LP_Rut__c);

        LP_JSONBeCleverRequest.Datosinput codigoAutorizacion = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput customLists = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput customListsLimits = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput cupoCampania = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput rutSinDv = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput digitoVerificador = new LP_JSONBeCleverRequest.Datosinput();
        LP_JSONBeCleverRequest.Datosinput cardTypes = new LP_JSONBeCleverRequest.Datosinput();
        List<LP_JSONBeCleverRequest.Datosinput> datInputs = new List<LP_JSONBeCleverRequest.Datosinput>();

        codigoAutorizacion.Descripcion = 'CodigoAutorizacion';
        codigoAutorizacion.Valor = this.azurianToken;
        datInputs.add(codigoAutorizacion);
        customLists.Descripcion = 'CustomLists';
        customLists.Valor = obj.LP_TipoCliente__c;
        datInputs.add(customLists);
        customListsLimits.Descripcion = 'CustomListsLimits';
        customListsLimits.Valor = String.valueOf(obj.LP_Cupo__c);
        datInputs.add(customListsLimits);
        cupoCampania.Descripcion = 'Cupocampaña';
        cupoCampania.Valor = String.valueOf(obj.LP_Cupo__c);
        datInputs.add(cupoCampania);
        rutSinDv.Descripcion = 'RUT_SinDV';
        rutSinDv.Valor = obj.LP_Rut__c;
        datInputs.add(rutSinDv);
        digitoVerificador.Descripcion = 'DigitoVerificador';
        digitoVerificador.Valor = obj.LP_DV__c;
        datInputs.add(digitoVerificador);
        cardTypes.Descripcion = 'CardTypes';
        cardTypes.Valor = obj.LP_OfertaTarjeta__c;
        datInputs.add(cardTypes);
     
        reqBeClever.body.datosinput = datInputs;
        
	    reqBeClever.header = new LP_JSONHeaderRequest();
		reqBeClever.header.country = 'CL';
		reqBeClever.header.commerce = 'RF';
		reqBeClever.header.channel = 'CRM';
        
        return reqBeClever;
    }
	
    /**
    *  @Description: BeClever validation json mapping
    *  @Autor:       ASC, Deloitte, asanhuezac@deloitte.com
    *  @Date:        08/06/2021
    */
    public String call(){
        
		Map<String, String> pathParam = new Map<String, String>();
		Map<String, String> mapHeader = new Map<String, String>();
		Map<String, String> mapQuery = new Map<String, String>();
		Map<String, Map<String, String>> setConf = new Map<String, Map<String, String>>();
		setConf.put('header', mapHeader);
		setConf.put('path', pathParam);
		setConf.put('query', mapQuery);
		
		LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth(PRV_URL_BASEURL, PRV_SRV_BECLEVER);
		String rsp = objClass.callServiceWithToken(setConf, JSON.serialize(mapping(), true)).getBody();
        return rsp;
    }
}