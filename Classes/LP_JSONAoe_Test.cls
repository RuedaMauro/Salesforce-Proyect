@isTest
public without sharing class LP_JSONAoe_Test {
    @testSetup
        static void setupMethod() {
        }
    
    @isTest static void JsonAoe_TEST() {
 		Test.startTest();
        LP_JSONAoe577Request a= LP_JSONAoe577Request.parse('{"rut":"111111","dv":"1"}');
        System.assertNotEquals(null,a);
        LP_JSONAoe577Response ar= LP_JSONAoe577Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,ar);
        LP_JSONAoe279Request b= LP_JSONAoe279Request.parse('{"rut":"11111111","dv":"2","channel":"2"}');
        System.assertNotEquals(null,b);
        LP_JSONAoe279Response br= LP_JSONAoe279Response.parse('{"security_Cod":"11111111","name":"tester"}');
        System.assertNotEquals(null,br);
        LP_JSONAoe646Request c= LP_JSONAoe646Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,c);
        LP_JSONAoe646Response cr= LP_JSONAoe646Response.parse('{"fechaVencimiento":"01/02/2020","facturada":"si"}');
        System.assertNotEquals(null,cr);
        LP_JSONAoe1172Request d= LP_JSONAoe1172Request.parse('{"cuenta":"11111111","dv":"2"}');
        System.assertNotEquals(null,d);
        LP_JSONAoe1172Response dr= LP_JSONAoe1172Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,dr);
        LP_JSONAoe207Request e= LP_JSONAoe207Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,e);
        LP_JSONAoe207Response er= LP_JSONAoe207Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,er);
        LP_JSONAoe220Request f= LP_JSONAoe220Request.parse('{"rut":"11111111","dv":"2"}');
        System.assertNotEquals(null,f);
        LP_JSONAoe220Response fr= LP_JSONAoe220Response.parse('{"clienteRut":"11111111","clienteDv":"2"}');
        System.assertNotEquals(null,fr);
        
        
        Test.stopTest();    
    }
    
}