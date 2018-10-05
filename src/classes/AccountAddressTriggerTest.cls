@isTest
public class AccountAddressTriggerTest {
	@testsetup
    static void setup()
    {
        List<Account> accList = new List<Account>();
        for(Integer i=1;i<=200;i++)
        {
            accList.add(new Account(name='acc '+i,
                                    BillingPostalCode='AB1234',Match_Billing_Address__c=true));
        }
        insert accList;
    }
    static testmethod void InsertTest() {        
        Test.startTest();
        List<Account> triggeredAccounts = [Select Id,Name,BillingPostalCode from Account
                                          where ShippingPostalCode='AB1234'];
       	System.assertEquals(200, triggeredAccounts.size());
        Test.stopTest();
    }
    
    static testmethod void UpdateTest() {        
        Test.startTest();
        List<Account> triggeredAccounts = [Select Id,Name,BillingPostalCode from Account
                                          where ShippingPostalCode='AB1234'];
        for(Integer i=1;i<=10;i++)
        {
            triggeredAccounts[i].Match_Billing_Address__c=false;
            triggeredAccounts[i].BillingPostalCode='PQ123';
        }
        update triggeredAccounts;
        List<Account> triggeredAccounts2 = [Select Id,Name,BillingPostalCode from Account
                                          where ShippingPostalCode<>'PQ123' and BillingPostalCode='PQ123'];
       	System.assertEquals(10, triggeredAccounts2.size());
        Test.stopTest();
    }
    
}