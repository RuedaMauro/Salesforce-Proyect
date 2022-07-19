@isTest(SeeAllData=true)
private class PacienteBatchTest {
    static testmethod void test() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PatientResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');  
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, mock); 
        PacienteBatch b = new PacienteBatch();
        Database.executeBatch(b);
        Test.stopTest();
    }
}