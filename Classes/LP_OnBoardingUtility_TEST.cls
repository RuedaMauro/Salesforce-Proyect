/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Test Class for LP_OnboardingUtility
History      : Cross
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			08/06/2021		initial version
********************************************************************************/
@isTest
public with sharing class LP_OnBoardingUtility_TEST {

    @testSetup
    static void setupMethod() {
        LP_Nacionalidad__c nac = LP_DataFactory.createNationalityCL(true);
        LP_DataFactory.createAccountAndLeadWithRUT(true, nac);

        /*LP_Nacionalidad__c nac = new LP_Nacionalidad__c();
        nac.Name = 'CHILENA';
        nac.LP_CodigoNacionalidad__c = 'CHL';
        nac.LP_Pais__c = 'Chile';
        insert nac;
        
        Lead objLead = new Lead();
        objLead.FirstName = 'Juan Perez';
        objLead.LastName = 'Moya';
        objLead.LP_ApellidoMaterno__c = 'Mora';
        objLead.LP_Rut__c = '16246687-9';
        objLead.LP_Nacionalidad__c = nac.id;
        objLead.LP_Genero__c = 'V';
        objLead.Email = 'notiene@notiene.cl';
        objLead.MobilePhone = '+56945324567';
        insert objLead;

        Account acc = new Account();
        acc.FirstName = 'Jose Luis';
        acc.LastName = 'Lobos';
        acc.LP_ApellidoMaterno__pc = 'Toro';
        acc.LP_Rut__c = '21871853-1';
        acc.LP_Nacionalidad__pc = nac.id;
        acc.LP_Genero__pc = 'V';
        acc.PersonEmail = 'notiene@notiene.cl';
        acc.PersonMobilePhone = '+56945324567';
        acc.Vass_Rut__c = '12345678-9';
        insert acc;*/

        Lead objLead = [SELECT Id,FirstName, LastName, LP_Rut__c, LP_Nacionalidad__c, LP_ApellidoMaterno__c FROM Lead WHERE LP_Rut__c = '16246687-9' LIMIT 1];
    
        LP_Onboarding__c objOnb = new LP_Onboarding__c();
        objOnb.LP_Ruta__c = 'paso-2';
        objOnb.LP_CorreoElectronico__c = 'pepito@pagadoble.cl';
        objOnb.LP_Candidato__c = objLead.Id;
        insert objOnb;

	}

    /**
    * @description Test get Onboarding Obj Lead
    * @Autor       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    * @date        08/06/2021
    */ 
    @isTest
    static void getOnboardingObjLeadTest(){
        
        Lead objLead = [SELECT FirstName, LastName, LP_Rut__c, LP_Nacionalidad__c, LP_ApellidoMaterno__c FROM Lead WHERE LP_Rut__c = '16246687-9' LIMIT 1];
        LP_OnBoarding__c objOnb = [SELECT Id FROM LP_OnBoarding__c WHERE LP_Candidato__c =: objLead.Id];
        
        Test.startTest();
        LP_OnBoardingUtility.WrapObject wrp = new LP_OnBoardingUtility.WrapObject(objOnb);
        wrp = LP_OnBoardingUtility.getOnboardingObj(wrp);
        System.debug('existsLead: '+wrp.existsAcc);
        System.assertEquals(wrp.existsAcc, true, 'OK getOnboardingLeadObj');
        Test.stopTest();
    }

}