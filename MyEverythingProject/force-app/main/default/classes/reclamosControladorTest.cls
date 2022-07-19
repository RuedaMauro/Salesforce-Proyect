@isTest
public class reclamosControladorTest {

    @isTest
    public static void test1(){
        
        Area__c ar = New Area__c();
        ar.name = 'Area Test';
        ar.Encargado_de_area__c = 'Test';
        ar.Correo_electronico_de_area__c = 'test@test.com';
        insert ar;
        
        Area_de_caso__c ac = New Area_de_caso__c();
        ac.area__c = ar.id;
        ac.Fecha_de_asignacion__c = Date.today();
        insert ac;
 		reclamosControlador rc = New reclamosControlador();
        
        pageReference pr = rc.enviarRespuesta();
    	Area_de_caso__c ac1 = rc.getArea();
        List<Comentario_de_caso__c> com = rc.getComentarios();
        
        rc.respuesta = 'R';
         pageReference pr1 = rc.enviarRespuesta();
    }
}