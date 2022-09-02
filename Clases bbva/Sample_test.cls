/**
* @author BBVA ADT Team
* @date 2018
*/
@isTest
public class Sample_test {

    /**
      * @description Test method
      */
    @isTest static void sumTest() {

        Test.startTest();
        final Decimal result = Sample.sum(3, 4);
        System.assertEquals(result, 7, result + ' is not equals to 7');
        Test.stopTest();
    }
}