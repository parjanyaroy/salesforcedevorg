@isTest(seeAllData=true)
public class AccountProcessorTest {
    private static testMethod void testMethod1() 
    {
    	System.debug('Hello');
        List<Id> testList= new List<Id>();
        testList.add('0017F00000lJhXwQAK');
        Test.startTest();
        AccountProcessor.countContacts(testList);
        Test.stopTest();
    }
}