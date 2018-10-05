@isTest
public class LeadProcessorTest {
	@testsetup
    static void setup()
    {
        List<Lead> leadList = new List<Lead>();
        for(Integer i=1;i<=200;i++)
        {
            leadList.add(new Lead(lastname='lastname '+i, company='company '+i));
        }
        insert leadList;
    }
    static testmethod void test() {        
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProcessor);
        Test.stopTest();
        //after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}