@isTest(SeeAllData=true)
private class ProfesionalBatchTest {
    static testmethod void test() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('ProfesionalesResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json'); 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock); 
        ProfesionalBatch b = new ProfesionalBatch();
        Database.executeBatch(b);
        Test.stopTest();
    }
}