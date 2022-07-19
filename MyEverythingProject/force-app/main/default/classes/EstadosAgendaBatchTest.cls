@isTest(SeeAllData=true)
private class EstadosAgendaBatchTest {
    static testmethod void test() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json'); 
        Test.startTest();
 		Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator()); 
        Database.executeBatch(new EstadosAgendaBatch(),200);
        Test.stopTest();
    }
}