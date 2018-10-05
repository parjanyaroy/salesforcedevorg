trigger AccountAddressTrigger on Account (before insert,before update) {
        if(Trigger.isBefore)
        {
            if(Trigger.isInsert)
            {
                for(Account acc :Trigger.New)
                {
                    if(acc.Match_Billing_Address__c==true)
                    {
       				acc.ShippingPostalCode=acc.BillingPostalCode;
                    }
                }
            }
            else if(Trigger.isUpdate)
            {
                for(Account acc :Trigger.New)
                {
                if(acc.Match_Billing_Address__c!=Trigger.oldMap.get(acc.Id).Match_Billing_Address__c
                  && acc.Match_Billing_Address__c==true )
                {
                    acc.ShippingPostalCode=acc.BillingPostalCode;
                }
                }
               
            }
        }
    
    }