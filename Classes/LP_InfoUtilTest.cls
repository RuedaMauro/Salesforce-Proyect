@isTest
public class LP_InfoUtilTest {

    @testSetup static void setup() {
        LP_Documentos__c doc = New LP_Documentos__c();
        doc.LP_Categoria__c = 'Contratos y Plan de descuentos';
        insert doc;
        
        LP_Documentos__c base = New LP_Documentos__c();
        base.LP_Categoria__c = 'Bases Legales';
        insert base;
    }
    
    @isTest
    public static void getDocs(){
        List<LP_Documentos__c> listaDocs = LP_InfoUtil.getFiles();
        system.assert(listaDocs.size() == 1);
    } 
    
    @isTest
    public static void getBases(){
        List<LP_Documentos__c> listaBases = LP_InfoUtil.getBases();
        system.assert(listaBases.size() == 1);
    } 
}