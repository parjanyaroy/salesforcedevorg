public class AccountProcessor {

    @future
    public static void countContacts(List<Id> Ids)
    {
        System.debug('Hi Again');
        Account currentaccount;
        for(Id id : Ids)
        {
            Integer currentcount = [SELECT COUNT() FROM Contact WHERE AccountId=:id ];
            currentaccount = [SELECT Number_of_Contacts__c FROM Account WHERE Id=:id];
            currentaccount.Number_of_Contacts__c=currentcount;
            update currentaccount;
		}
    }
    
}