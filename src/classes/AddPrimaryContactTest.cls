@isTest
public class AddPrimaryContactTest {

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                BillingState='NY',
                Name='Test Account1' +i
            ));
            accounts.add(new Account(
                BillingState='CA',
                Name='Test Account2'+ i
            ));
        }
        insert accounts;
    }
    
    static testmethod void testQueueable() {
        Contact c1 = new Contact();
        AddPrimaryContact insertContacts = new AddPrimaryContact(c1,'CA');
        Test.startTest();        
        System.enqueueJob(insertContacts);
        Test.stopTest();        
        System.assertEquals(50, [select count() from contact]);
    }
    
}