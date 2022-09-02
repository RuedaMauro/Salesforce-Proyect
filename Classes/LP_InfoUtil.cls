global with sharing class LP_InfoUtil {

     /**
    *  @Description: Get Files.
    *  @Author:      Damián Biaggio, Deloitte, dbiaggio@deloitte.com
    *  @Date:        23/06/2021  
    */
    @AuraEnabled
    public static List<LP_Documentos__c> getFiles(){
        return [SELECT Id, LP_NombreDocumento__c, LP_EstadoVigencia__c, LP_FechaVigencia__c, LP_VinculoPublico__c FROM LP_Documentos__c WHERE LP_Categoria__c = 'Contratos y Plan de descuentos'];
    }
    
    @AuraEnabled
    public static List<LP_Documentos__c> getBases(){
        return [SELECT Id, LP_NombreDocumento__c, LP_EstadoVigencia__c, LP_FechaVigencia__c, LP_VinculoPublico__c FROM LP_Documentos__c WHERE LP_Categoria__c = 'Bases Legales'];
    } 
}