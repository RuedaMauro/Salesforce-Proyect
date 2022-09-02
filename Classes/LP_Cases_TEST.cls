@isTest
public class LP_Cases_TEST {
	
    @testSetup 
    static void setupMethod() {
        LP_DataFactory.createAccount();    
	}
	 /*    
    @isTest static  void CaseMilestones_TEST() {
        Account cuenta = [Select id From Account Limit 1];
        
        test.startTest();
            Case cas = LP_DataFactory.createCase(cuenta);
            cas.OwnerId = userInfo.getUserId();
            update cas;
        	
        	cas.LP_CreacionTarea__c = true;
        	update cas;
        
        	cas.Status = 'En Gestión';
        	update cas;
        
        	cas.Status = 'Gestionado';
        	update cas;
        
        	cas.Status = 'Cancelado';
        	update cas;
        
        test.stopTest();
    }
	*/

    @isTest static void caseCommitmentDate_TEST() {
        Account cuenta = [Select id From Account Limit 1];
        
        test.startTest();
            Case cas = LP_DataFactory.createCase(cuenta);
        test.stopTest();
    }
}