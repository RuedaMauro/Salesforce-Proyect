@isTest
private class RecordTypesServiceTest
{
    private static final String PATIENT_DEV_NAME = 'PersonAccount';
    private static final String PATIENT_NAME = 'Paciente';

    @isTest
    private static void shouldRetrieveRecordTypeInfoByDeveloperName()
    {
        //GIVEN THERE ARE RECORD TYPES
        //WHEN GetByRecordTypeId based on dev name
        Test.startTest();
        
        Id actual = RecordTypesService.getRecordTypeId(Account.getSObjectType(), PATIENT_DEV_NAME);

        Test.stopTest();
        //THEN recordTypeId should be returned
        Id expected = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(PATIENT_DEV_NAME).getRecordTypeId();
        System.assertEquals(expected, actual);
    }

    @isTest
    private static void shouldRetrieveRecordTypeInfoByName()
    {
        //GIVEN THERE ARE RECORD TYPES
        //WHEN GetByRecordTypeId based on dev name
        Test.startTest();
        
        Id actual = RecordTypesService.getRecordTypeIdFromName(Account.getSObjectType(), PATIENT_NAME);

        Test.stopTest();
        //THEN recordTypeId should be returned
        Id expected = Schema.SObjectType.Account.getRecordTypeInfosByName().get(PATIENT_NAME).getRecordTypeId();
        System.assertEquals(expected, actual);
    }
}