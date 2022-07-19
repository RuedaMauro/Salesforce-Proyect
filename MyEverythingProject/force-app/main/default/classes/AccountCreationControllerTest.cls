@isTest
public class AccountCreationControllerTest {

    @isTest
    public static void testSolicitarPresupuesto(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId();

        Product2 pro = new Product2(Name = 'Cirugia');
        insert pro;

        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 standardPricebook = new Pricebook2(
            Id = pricebookId,
            IsActive = true
        );
        update standardPricebook;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

        Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Codigo_del_profesional__c = '1014862377'
        );
        insert prof;

        Map<String,Object> cuentaMap =new Map<String,Object>{
            'Celular_del_Paciente__c' => '31215484645',
            'Ciudad_de_residencia__c' => 'Bogota',
            'FirstName' => 'Test',
            'LastName' => 'Account',
            'Numero_de_ID__c' => '1012548564',
            'Numero_telefonico_de_contacto_adicional__c' => '31215484685',
            'Pais_de_residencia__c' => 'Colombia',
            'PersonBirthdate' => '2000-04-05',
            'PersonEmail' => 'test@user.com',
            'Sexo__c' => 'Masculino',
            'Tipo_de_ID__c' => '4'
        };
        Map<String,Object> oppMap =new Map<String,Object>{
            'Canal_de_solicitud__c' => 'Web',
            'Description' => 'NAda',
            'Dias_de_estancia_piso__c' => '1',
            'Informacionode_la_solicitud__c' => 'NAda',
            'Tiempo_estimado_de_duracion__c' => '1',
            'Tiene_orden_medica__c' => 'No',
            'Tipo_de_anestesia__c' => 'Local',
            'Tipo_de_estancia__c' => 'Ambulatorio',
            'Tipo_de_solicitante__c' => 'Funcionario Oficina de Presupuestos'
        };

        Test.startTest();
        List<String> cedProf = new List<String> ();
        cedProf.add(prof.Codigo_del_profesional__c);
        Opportunity returnOpp = AccountCreationController.solicitarPresupuesto(cuentaMap, oppMap, cedProf, new List<String>{ pbe.Id });
        Test.stopTest();
        List<Account> listAcc = [SELECT Id, Name FROM Account];
        System.assert(returnOpp != null);
        System.assertEquals(1, listAcc.size(), 'Size not Equal' + listAcc);
    }

    @isTest
    static void testSolicitarPresupuestoWithoutAcc(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        Id profRecTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Profesional').getRecordTypeId();

        Product2 pro = new Product2(Name = 'Cirugia');
        insert pro;

        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 standardPricebook = new Pricebook2(
            Id = pricebookId,
            IsActive = true
        );
        update standardPricebook;

        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = pro.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

        Contact prof = new Contact(
            RecordTypeId = profRecTypeId,
            LastName = 'Prof', 
            Codigo_del_profesional__c = '1014862355'
        );

        Account acc = new Account(
            LastName = 'Test', 
            Numero_de_ID__c = '1014862377',
            Tipo_de_ID__c = '4',
            RecordTypeId = accRecTypeId
        );
        insert acc;

        Map<String,Object> oppMap =new Map<String,Object>{
            'Canal_de_solicitud__c' => 'Web',
            'Description' => 'NAda',
            'Dias_de_estancia_piso__c' => '1',
            'Informacionode_la_solicitud__c' => 'NAda',
            'Tiempo_estimado_de_duracion__c' => '1',
            'Tiene_orden_medica__c' => 'No',
            'Tipo_de_anestesia__c' => 'Local',
            'Tipo_de_estancia__c' => 'Ambulatorio',
            'Tipo_de_solicitante__c' => 'Funcionario Oficina de Presupuestos'
        };

        Test.startTest();
         List<String> cedProf = new List<String> ();
        cedProf.add(prof.Codigo_del_profesional__c);
        Opportunity returnOpp = AccountCreationController.solicitarPresupuestoWithoutAcc(oppMap, '1014862377', cedProf, new List<String>{ pbe.Id });
        Test.stopTest();
        List<OpportunityLineItem> listOppLineItem = [SELECT Id, Quantity FROM OpportunityLineItem];
        System.assertEquals(1, listOppLineItem.size());
    }

    @isTest
    static void testCheckExistingSolicitante(){
        Id accRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();
        Account acc = new Account(
            LastName = 'Test', 
            Numero_de_ID__c = '1014862377',
            Tipo_de_ID__c = '4',
            RecordTypeId = accRecTypeId
        );
        insert acc;
        Test.startTest();
        String returnString = AccountCreationController.checkExistingSolicitante(acc.Numero_de_ID__c);
        Test.stopTest();
        System.assertEquals('4', returnString);
    }

    @isTest(SeeAllData = true)
    static void testGetDataLookup(){
        Test.startTest();
        List<LookupSearchResult> resultsNacional = AccountCreationController.getDataLookup('pla', new List<String>{}, '4');
        List<LookupSearchResult> resultsInternacional = AccountCreationController.getDataLookup('pla', new List<String>{}, 'p');
        Test.stopTest();
        System.assert(!resultsNacional.isEmpty());
        System.assert(!resultsInternacional.isEmpty());
    } 
    
    @isTest(SeeAllData = true)
    static void testGetProfesional(){
        Test.startTest();
        List<LookupSearchResult> lr ;
        lr = AccountCreationController.getProfesional('1');
        Test.stopTest();
        System.assert(!lr.isEmpty());
    }
    
    @isTest
    static void testUploadFile(){
        Test.startTest();
        String returnString ;
        try{
            returnString = AccountCreationController.uploadFile('ttt','file.jpg',null);
        }catch(Exception ex){}        
        Test.stopTest();
        System.assert(String.isBlank(returnString));
    }
	
    @isTest
    static void testCreateContentVersion(){
        Test.startTest(); 
        ContentVersion returnCont ;        
        try{
            returnCont = AccountCreationController.createContentVersion('ttt','file.jpg');
        }catch(Exception ex){}
        Test.stopTest();
        System.assert(returnCont!=null);
    }
}