public without sharing class AccountCreationJHController {
    private static final String PRICEBOOK_INTERNACIONAL = 'Pago directo Internacional PDI';
    private static final String PRICEBOOK_NACIONAL = 'Pago directo nacional PDN';

    @AuraEnabled
    public static Opportunity solicitarPresupuesto(Map<String,Object> cuentaMap, Map<String,Object> oppMap, String cedProf, List<String> items){
        Opportunity returnOpp;
        if(!cuentaMap.isEmpty()){
            if(String.isNotBlank(String.valueOf(cuentaMap.get('LastName')))){
                Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Solicitante').getRecordTypeId();
                List<String> birthDate = String.valueOf(cuentaMap.get('PersonBirthdate')).split('-');
                System.debug('Fecha nacimiento '+birthDate);
                Account acct = new Account(
                    RecordTypeId = accRecTypeId,
                    FirstName = String.isNotBlank(String.valueOf(cuentaMap.get('FirstName'))) ? String.valueOf(cuentaMap.get('FirstName')) : null,
                    LastName = String.isNotBlank(String.valueOf(cuentaMap.get('LastName'))) ? String.valueOf(cuentaMap.get('LastName')) : null,
                    Celular_del_Paciente__c = String.isNotBlank(String.valueOf(cuentaMap.get('Celular_del_Paciente__c'))) ? String.valueOf(cuentaMap.get('Celular_del_Paciente__c')) : null,
                    Sexo__c = String.isNotBlank(String.valueOf(cuentaMap.get('Sexo__c'))) ? String.valueOf(cuentaMap.get('Sexo__c')) : null,
                    PersonBirthdate = !birthDate.isEmpty() ? Date.newInstance(Integer.valueOf(birthDate[0]),Integer.valueOf(birthDate[1]),Integer.valueOf(birthDate[2])) : null,
                    Tipo_de_ID__c = String.isNotBlank(String.valueOf(cuentaMap.get('Tipo_de_ID__c'))) ? String.valueOf(cuentaMap.get('Tipo_de_ID__c')) : null,
                    Numero_de_ID__c = String.isNotBlank(String.valueOf(cuentaMap.get('Numero_de_ID__c'))) ? String.valueOf(cuentaMap.get('Numero_de_ID__c')) : null,
                    Pais_de_residencia__c = String.isNotBlank(String.valueOf(cuentaMap.get('Pais_de_residencia__c'))) ? String.valueOf(cuentaMap.get('Pais_de_residencia__c')) : null,
                    Ciudad_de_residencia__c = String.isNotBlank(String.valueOf(cuentaMap.get('Ciudad_de_residencia__c'))) ? String.valueOf(cuentaMap.get('Ciudad_de_residencia__c')) : null,
                    Numero_telefonico_de_contacto_adicional__c = String.isNotBlank(String.valueOf(cuentaMap.get('Numero_telefonico_de_contacto_adicional__c'))) ? String.valueOf(cuentaMap.get('Numero_telefonico_de_contacto_adicional__c')) : null,
                    PersonEmail = String.isNotBlank(String.valueOf(cuentaMap.get('PersonEmail'))) ? String.valueOf(cuentaMap.get('PersonEmail')) : null
                );
                try{
                    insert acct;
                    returnOpp = createOpp(oppMap, cedProf, items, acct.FirstName + ' ' + acct.LastName, acct.Id);
                }catch(Exception ex){
                    System.debug(ex.getMessage());
                    throw new AuraHandledException(ex.getMessage()); 
                }
            }
        }
        
        return returnOpp;
    }
    
    @AuraEnabled
    public static Opportunity solicitarPresupuestoWithoutAcc(Map<String,Object> oppMap, String numCed, String cedProf, List<String> items){
        Opportunity returnOpp;
        List<Account> accExisting = [SELECT Id, FirstName, LastName, Numero_de_ID__c FROM Account WHERE Numero_de_ID__c =: numCed LIMIT 1];
        if(!accExisting.isEmpty()){
            returnOpp = createOpp(oppMap, cedProf, items, accExisting[0].FirstName + ' ' + accExisting[0].LastName, accExisting[0].Id);
        }
        return returnOpp;
    }

    public static Opportunity  createOpp(Map<String,Object> oppMap, String cedProf, List<String> items, String accName, Id accId){
        Opportunity returnOpp;
        if(!oppMap.isEmpty()){
            Opportunity opp = new Opportunity(
                AccountId = accId,
                Name = accName + ' - ' + String.valueOf(oppMap.get('Canal_de_solicitud__c')) + ' - ' + items.size() + ' Servicios',
                StageName = 'Nuevo presupuesto',
                CloseDate = date.today().addDays(3),
                ForecastCategoryName = 'Omitted',
                Canal_de_solicitud__c = String.valueOf(oppMap.get('Canal_de_solicitud__c')),
                Tipo_de_solicitante__c = String.valueOf(oppMap.get('Tipo_de_solicitante__c')),
                Tiene_orden_medica__c = String.valueOf(oppMap.get('Tiene_orden_medica__c')),
                Informacionode_la_solicitud__c = String.valueOf(oppMap.get('Informacionode_la_solicitud__c')),
                Tipo_de_anestesia__c = String.valueOf(oppMap.get('Tipo_de_anestesia__c')),
                EPS_del_paciente__c = String.valueOf(oppMap.get('EPS_del_paciente__c')),
                Convenio_reportado_en_el_formulario__c	 = String.valueOf(oppMap.get('Convenio_reportado_en_el_formulario__c	')),
                Nombre_acudiente_del_paciente__c = String.valueOf(oppMap.get('Nombre_acudiente_del_paciente__c')),
                Medico_quien_ordena__c = String.valueOf(oppMap.get('Medico_quien_ordena__c')),
                Tiempo_estimado_de_duracion__c = String.isNotBlank(String.valueOf(oppMap.get('Tiempo_estimado_de_duracion__c'))) 
                    ? Integer.valueOf(oppMap.get('Tiempo_estimado_de_duracion__c'))
                    : 0,
                Description = String.valueOf(oppMap.get('Description')),
                Tipo_de_estancia__c = String.valueOf(oppMap.get('Tipo_de_estancia__c')),
                Dias_de_estancia_piso__c = String.isNotBlank(String.valueOf(oppMap.get('Dias_de_estancia_piso__c'))) 
                    ? Integer.valueOf(oppMap.get('Dias_de_estancia_piso__c'))
                    : 0
            );
            /* if(String.isNotBlank(cedProf)){
                List<Contact> profesional = [SELECT Id, Codigo_del_profesional__c FROM Contact WHERE Codigo_del_profesional__c =: cedProf LIMIT 1];
                if(!profesional.isEmpty()){
                    opp.Profesional_quien_ordena__c = profesional[0].Id;
                }
            } */
            try {
                insert opp;
            } catch (Exception ex) {
                System.debug(ex.getMessage());
                throw new AuraHandledException(ex.getMessage()); 
            }
            if(String.isNotBlank(String.valueOf(opp.Id))){
                List<PricebookEntry> listPriceBookEntry = [SELECT Name, Id, UnitPrice FROM PricebookEntry WHERE Id IN : items];
                List<OpportunityLineItem> itemsInsertar = new List<OpportunityLineItem>();
                for(PricebookEntry pb : listPriceBookEntry){
                    OpportunityLineItem newItem = new OpportunityLineItem(
                        OpportunityId = opp.id,
                        Quantity = 1,
                        TotalPrice = pb.UnitPrice,
                        PricebookEntryId = pb.Id
                    );
                    itemsInsertar.add(newItem);
                }
                try{
                    insert itemsInsertar;
                    returnOpp = opp;
                } catch (Exception ex) {
                    System.debug(ex.getMessage());
                    throw new AuraHandledException(ex.getMessage()); 
                }
            }
        }
        return returnOpp;
    }

    @AuraEnabled(cacheable=true)
    public static String checkExistingSolicitante(String numCed){
        String returnString;
        List<Account> listSolici = [SELECT Id, Numero_de_ID__c, Tipo_de_ID__c 
                                    FROM Account 
                                    WHERE Numero_de_ID__c =: numCed 
                                    LIMIT 1];
        if(!listSolici.isEmpty()){
            returnString = listSolici[0].Tipo_de_ID__c;
        }else{
            returnString = 'No valido';
        }
        return returnString;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<LookupSearchResult> getDataLookup(String searchTerm, List<String> selectedIds, String tipoDeDoc){
        List<PricebookEntry> listPriceBookEntry = new List<PricebookEntry>();
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        String pricebookName;
        String product = '%' + searchTerm + '%'; 
        if(tipoDeDoc == '5' || tipoDeDoc == 'P' || tipoDeDoc == 'D'){
            pricebookName = PRICEBOOK_INTERNACIONAL;
        }else{
            pricebookName = PRICEBOOK_NACIONAL;
        }
        PriceBook2 pricebook = [SELECT Id, Name
                                FROM PriceBook2 
                                WHERE Name =: pricebookName 
                                LIMIT 1];
        listPriceBookEntry = [SELECT Name, Id, UnitPrice, Product2.Especialidad__c 
                                FROM PricebookEntry 
                                WHERE Pricebook2Id =: pricebook.Id 
                                AND Name LIKE : product 
                                AND Id NOT IN : selectedIds];
        for(PricebookEntry prib : listPriceBookEntry){
            results.add(new LookupSearchResult(prib.Id, 'PricebookEntry', 'standard:price_book_entries', prib.Name, prib.Product2.Especialidad__c));
        }
        results.sort();
        return results;
    }

    @AuraEnabled
    public static String uploadFile(String base64, String filename, String recordId) {
            ContentVersion cv = createContentVersion(base64, filename);
            ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
            if (cv == null || cdl == null) { return null; }
            return cdl.Id;
    }

    private static ContentVersion createContentVersion(String base64, String filename) {
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        try {
          insert cv;
          return cv;
        } catch(DMLException e) {
          System.debug(e);
          return null;
        }
    }

    private static ContentDocumentLink createContentLink(String contentVersionId, String recordId) {
        if (contentVersionId == null || recordId == null) { return null; }
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [
        SELECT ContentDocumentId 
        FROM ContentVersion 
        WHERE Id =: contentVersionId
        ].ContentDocumentId;
        cdl.LinkedEntityId = recordId;
        // ShareType is either 'V', 'C', or 'I'
        // V = Viewer, C = Collaborator, I = Inferred
        cdl.ShareType = 'V';
        try {
        insert cdl;
        return cdl;
        } catch(DMLException e) {
        System.debug(e);
        return null;
        }
    }
}