@isTest
private class OpportunityCalculateDaysTest {
    
    static testmethod void testAddBussinessDays(){
        OpportunityCalculateDays op = new OpportunityCalculateDays();
		Date start = Date.newInstance(2022, 4, 26);
        Date validate = Date.newInstance(2022, 4, 29);
    	Date d = OpportunityCalculateDays.addBussinessDays(start, 3);
        System.assertEquals(validate, d);
    }

}