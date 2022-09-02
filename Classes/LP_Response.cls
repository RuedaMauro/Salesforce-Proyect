/*********************************************************************************
Project      : LA POLAR Salesforce - Sitio Privado
Created By   : Deloitte
Created Date : 25/06/2021
Description  : Object used for communication between back and front end.
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Damian Alejandro Biaggio    DAB
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      DAB			01/06/2021		initial version
********************************************************************************/
public with sharing class LP_Response {
    @AuraEnabled public List<LP_JSONAoe212Response.Items> facturationItems;
    @AuraEnabled public List<getDocs> docs;
    @AuraEnabled public List<HistoryPayment> paymentHistory = new List<HistoryPayment>();
	@AuraEnabled public Integer rut;
    @AuraEnabled public Blob docblob;
    @AuraEnabled public List<Aditionals> aditionals = new List<Aditionals>();
    @AuraEnabled public String comuna;
    @AuraEnabled public String domicilio;
    @AuraEnabled public String dv;
    @AuraEnabled public String token;
    @AuraEnabled public String day_birth;
    @AuraEnabled public String email;
    @AuraEnabled public String last_Name_1;
    @AuraEnabled public String last_Name_2;
    @AuraEnabled public String name;
    @AuraEnabled public String tarjetaCod;
    @AuraEnabled public String blockCode;
    @AuraEnabled public boolean creditClient;
    @AuraEnabled public String centalta;
    @AuraEnabled public String cuenta;
    @AuraEnabled public String message;
    @AuraEnabled public String code; 
    @AuraEnabled public String no_movil;
    @AuraEnabled public boolean loginOK = false;
    @AuraEnabled public boolean existingAccount;
    @AuraEnabled public String URL;
    @AuraEnabled public boolean renegSituation;
    @AuraEnabled public String dispav;
    @AuraEnabled public Integer dispavxl;
    @AuraEnabled public String dispcompra;
    @AuraEnabled public String utilcompra;
    @AuraEnabled public String cupocompras;
    @AuraEnabled public Integer cupoavance;
    @AuraEnabled public Integer cupoavancexl;
    @AuraEnabled public Integer utilsup;
    @AuraEnabled public String utilpav;
    @AuraEnabled public String utilavxl;
    @AuraEnabled public boolean deudaPendiente;
    @AuraEnabled public String montov;
    @AuraEnabled public String fechav;
    @AuraEnabled public String deudatotal;
    @AuraEnabled public Integer deudatotal_r;
    @AuraEnabled public Integer cuotamax;
    @AuraEnabled public Integer cuotamin;
    @AuraEnabled public Integer pago30;
    @AuraEnabled public String fechaVencimiento;
    @AuraEnabled public String fechaFacturacion;
    @AuraEnabled public String facturada;
    @AuraEnabled public String tarjetaEmitidaPan;
    @AuraEnabled public boolean incorrectPassword;
    @AuraEnabled public List<LP_JSONAoe189Response.Items> lastMovements;
    @AuraEnabled public String fechaVencTarjeta;
    @AuraEnabled public String codTar;
    @AuraEnabled public boolean createdPin;
    @AuraEnabled public boolean VisaClient;
    @AuraEnabled public boolean blockCard;
    @AuraEnabled public boolean userBlocked = false;
    @AuraEnabled public String dias_mora;
    @AuraEnabled public String tipofac;
    @AuraEnabled public String tipofac3;
    @AuraEnabled public String tasa;
    @AuraEnabled public String tasa3;
    @AuraEnabled public Integer tasa_i;
    @AuraEnabled public Integer tasa3_i;
    @AuraEnabled public String deudacompra;
    @AuraEnabled public String deudaavance;
    @AuraEnabled public String deudaavancexl;
    @AuraEnabled public String imptotalL1;
    @AuraEnabled public String impcuotaL1;
    @AuraEnabled public String doc;
    @AuraEnabled public String facemi;
    @AuraEnabled public String home_type;
    @AuraEnabled public String domicilio_num;
    @AuraEnabled public List<signedDoc> signedDocuments;
    @AuraEnabled public DateTime lastLoginDate;
    
    
    public class Aditionals{
        @AuraEnabled public String pan;
        @AuraEnabled public String name;
        @AuraEnabled public Integer codBlq;
        @AuraEnabled public String centalta;
        @AuraEnabled public boolean isPrimary;
    }
    
    public class HistoryPayment{
		@AuraEnabled public String nombre;
    	@AuraEnabled public Integer monto;
    	@AuraEnabled public String fecom;   
        @AuraEnabled public String month;
    }
    
    public class getDocs{
        @AuraEnabled public String rut;
    	@AuraEnabled public String proxperfac;
    	@AuraEnabled public String pan;
        @AuraEnabled public String dv;
        @AuraEnabled public String month;
        @AuraEnabled public String year;
    }
    
    public class signedDoc{
        @AuraEnabled public String id;
    	@AuraEnabled public String name;
    	@AuraEnabled public String docdate;
        @AuraEnabled public String link;
    }
}