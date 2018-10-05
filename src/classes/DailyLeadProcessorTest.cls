@isTest
public class DailyLeadProcessorTest {
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
        DailyLeadProcessor dailyleadProcessor = new DailyLeadProcessor();
        // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
		String sch = '20 30 8 10 2 ?';
		String jobID = System.schedule('Update Blank Leads', sch, dailyleadProcessor);
        Test.stopTest();
        //after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}