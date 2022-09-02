/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 08/06/2021
Description  : Class utility for OnBoarding
History      : Cross
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			08/06/2021		initial version
********************************************************************************/

public virtual inherited sharing class LP_OnBoardingUtility {
    
    private static LP_OnboardingSelector onboardingSelector;
    private static LP_AccountsSelector accSelector;
    private static LP_LeadsSelector leadSelector;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/06/2021
    */
    public static final String PBC_STR_STEPONE;
    public static final String PBC_STR_STEPTWO;
    public static final String PBC_STR_STEPTHREE;
    public static final String PBC_STR_STEPFOUR;
    public static final String PBC_STR_STEPFIVE;
    public static final String PBC_STR_STEPSIX;
    public static final String PBC_STR_STEPSEVEN;
    public static final String PBC_STR_NAMEDOCONE;
    public static final String PBC_STR_NAMEDOCTWO;
    public static final String PBC_STR_NAMEDOCTWOVISA;
    public static final String PBC_STR_NAMEDOCTHREE;
    public static final String PBC_STR_NAMEDOCFOUR;
    public static final String PBC_STR_NAMEDOCFIVE;
    public static final String PBC_API_TLPVISA;
    public static final String PBC_API_TLP;
    public static final Map<String, List<String>> PBC_MAP_DOCBYTYPECARD;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/06/2021
    */
    static {
        PBC_STR_STEPONE = Label.LP_OnboardingPaso1;
        PBC_STR_STEPTWO = Label.LP_OnboardingPaso2;
        PBC_STR_STEPTHREE = Label.LP_OnboardingPaso3;
        PBC_STR_STEPFOUR = Label.LP_OnboardingPaso4;
        PBC_STR_STEPFIVE = Label.LP_OnboardingPaso5;
        PBC_STR_STEPSIX = Label.LP_OnboardingPaso6;
        PBC_STR_STEPSEVEN = Label.LP_OnboardingPaso7;
        PBC_STR_NAMEDOCONE = 'Autorización Especial';
        PBC_STR_NAMEDOCTWO = 'Contrato Apertura Credito';
        PBC_STR_NAMEDOCTWOVISA = 'Contrato Apertura Linea Credito';
        PBC_STR_NAMEDOCTHREE = 'Mandato';
        PBC_STR_NAMEDOCFOUR = 'Resumen Contrato Apertura';
        PBC_STR_NAMEDOCFIVE = 'Constancia De Suscripción Onboarding';
        PBC_API_TLPVISA = '02';
        PBC_API_TLP = '01';
        PBC_MAP_DOCBYTYPECARD = new Map<String, List<String>>
                                {PBC_API_TLP => new List<String>{'1', '3', '5', '7'}
                                ,PBC_API_TLPVISA => new List<String>{'0', '6', '4', '2'}};
    }

    /**
    *  @Description: Get Onboarding record with a Lead or Account
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/06/2021
    */
    public static WrapObject getOnboardingObj(WrapObject wrap) {
        try {
            onboardingSelector = new LP_OnboardingSelector();
            if (wrap.type == SObjectType.Account.getName()) {
                wrap.onb = onboardingSelector.selectByAccountRutWithLimit(wrap.rut);
                wrap.acc = (Account)wrap.onb.LP_Cuenta__r;
                wrap.existsAcc = true;
                wrap.existsOnb = true;
            } else if (wrap.type == SObjectType.Lead.getName()) {
                wrap.onb = onboardingSelector.selectByLeadRutWithLimit(wrap.rut);
                wrap.lead = (Lead)wrap.onb.LP_Candidato__r;
                wrap.existsLead = true;
                wrap.existsOnb = true;
            }
        } catch(Exception e) {
            String message = new LP_CustomException.ExceptionDetail().getException(e);
        } finally {
            if (wrap.type == SObjectType.Account.getName() && !wrap.existsOnb) {
                accSelector = new LP_AccountsSelector();
                List<Account> accList = new List<Account>();
                accList = accSelector.selectByRutInAList(wrap.rut);
                wrap.acc = accList.size() > 0 ? accList[0] : null;
                wrap.existsAcc = accList.size() > 0 ? true : false;
                wrap.existsOnb = false;
            } else if (wrap.type == SObjectType.Lead.getName() && !wrap.existsOnb) {
                leadSelector = new LP_LeadsSelector();
                List<Lead> leadList = new List<Lead>();
                leadList = leadSelector.selectByRutInAList(wrap.rut);
                wrap.lead =  leadList.size() > 0 ? leadList[0] : new Lead();
                wrap.existsLead = leadList.size() > 0 ? true : false;
                wrap.existsOnb = false;
            }
        }
        return wrap;
    }

    /**
    *  @Description: Wrapper used to find out if a customer exists or not
    *  @Author:      Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        18/05/2021
    */
    public class WrapObject {
        @AuraEnabled public LP_Onboarding__c onb {get; set;}
        @AuraEnabled public Account acc {get; set;}
        @AuraEnabled public Lead lead {get; set;}
        @AuraEnabled public Boolean existsAcc {get; set;}
        @AuraEnabled public Boolean existsLead {get; set;}
        @AuraEnabled public Boolean existsOnb {get; set;}
        @AuraEnabled public String rut {get; set;}
        @AuraEnabled public String type {get;set;}
        
        // Constructor used to instantiate the onboarding object. The exists value indicates whether or not the record exists in the SFCD DB
        public WrapObject(LP_Onboarding__c o) {
            onb = o;
            existsOnb = false;
            existsAcc = false;
            existsLead = false;
            rut = '';
            type = SObjectType.Account.getName();
        }
    }

    /**
    *  @Description: PCRM-401: Method used to update the path on the client record
    *  @Author:      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        01/07/2021
    */
    public static void updateClientPath(LP_Onboarding__c onb) {
        onboardingSelector = new LP_OnboardingSelector();
        LP_Onboarding__c onbRecord = onboardingSelector.selectByOnboardingIdWithLimit(onb.id);
        if (onbRecord?.LP_Cuenta__c != null) {
            Account acc = new Account();
            acc.Id = onbRecord?.LP_Cuenta__c;
            acc.LP_RutaOnboarding__pc = onb?.LP_Ruta__c;
            update acc;
        }
    }
}