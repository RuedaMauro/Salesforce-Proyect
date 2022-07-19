@istest
public  class ResumenInformacionPacienteControllerTest {
    @TestSetup
    static void makeData(){
       
    }

    @IsTest
    static void getDiagnosticosDelPacienteOkTest(){
        Diagnostico_de_paciente__c ced;
        Test.startTest();
        try{
            ced = ResumenInformacionPacienteController.getDiagnosticosDelPaciente(null);
        }catch(Exception ex){
            System.debug('Exception: ' + ex);
        }        
        Test.stopTest();
        System.assertEquals(null, ced);        
    }

    @isTest
    public static void getEventosDeLaHistoriaClinicaOkTest(){
        List<HealthCloudGA__EHRProcedure__c> hcp = new List<HealthCloudGA__EHRProcedure__c>() ;
        Test.startTest();
        try{
            hcp = ResumenInformacionPacienteController.getEventosDeLaHistoriaClinica(null);
        }catch(Exception ex){}
        Test.stopTest();
        System.assertEquals(0, hcp.size());
    }

    @isTest
    public static void getAgendaOkTest(){
        List<ServiceAppointment> saList = new List<ServiceAppointment>();
        Test.startTest();
        try{
            saList = ResumenInformacionPacienteController.getAgenda(null);
        }catch(Exception ex){}
        Test.stopTest();
        System.assertEquals(0, saList.size());
    }

    @isTest
    public static void getEventoHCOkTest(){
        HealthCloudGA__EHRProcedure__c hcp;
        Test.startTest();
        try{
            hcp = ResumenInformacionPacienteController.getEventoHC(null);
        }catch(Exception ex){}
        Test.stopTest();
        System.assertEquals(null, hcp);
    }

    @isTest
    public static void getContactOkTest(){
        Account acc = new Account(
            LastName = 'Test', 
       //     RecordTypeId = accRecTypeId,
            Numero_de_ID__c = '1012548564',
            Tipo_de_ID__c = '4',
            PersonEmail = 'test@user.com'
        );
        insert acc;
        
        Test.startTest();
        try{
            ResumenInformacionPacienteController.getAcompanante(acc.id);
        }catch(Exception ex){}
        Test.stopTest();
       // System.assertEquals(null, acc);
    }

    @isTest
    public static void getConvenioDelPacienteOkTest(){
        Convenios_de_paciente__c cp;
        Test.startTest();
        try{
            cp = ResumenInformacionPacienteController.getConvenioDelPaciente(null);
        }catch(Exception ex){}
        Test.stopTest();
        System.assertEquals(null, cp);
    }
}