@isTest
public class testReclamosControlador {
    public static testMethod void test(){
        //creo área
        area__c a = new area__c();
        a.Encargado_de_area__c = 'test';
        a.Correo_electronico_de_area__c = 'test@test.com';
        insert a;
        //creo área de caso
        Area_de_caso__c ac = new Area_de_caso__c();
        ac.area__c = a.Id;
        //ac.Fecha_de_asignacion__c = Datetime.valueOf('2022-04-05T15:00:00.000+0000');
        //ac.Id = 'a1R02100000DWLcEAO';
        insert ac;
        //creo comentario de caso
        Comentario_de_caso__c cc = new Comentario_de_caso__c();
        cc.Area_de_caso__c = ac.Id;
        insert cc;
        
        Test.startTest();
        PageReference pageRef = Page.reclamos;
        Test.setCurrentPage(pageRef);
        reclamosControlador contest = new reclamosControlador();
        //contest.reclamosControlador();
        contest.getArea();
        contest.getComentarios();
        contest.enviarRespuesta();
        Test.stopTest();
    }
}