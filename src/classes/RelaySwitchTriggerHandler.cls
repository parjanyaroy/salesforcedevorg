public class RelaySwitchTriggerHandler {
    
    /**
     * This method is to be used in case of normal switching without any power outage occurring.
     * 
     */
    public static void createLogEvent(List<RelaySwitch__c> toggledSwitches)
    {
        List<SwitchLog__c> newRecords = new List<SwitchLog__c>();
        for(RelaySwitch__c switchToggled : toggledSwitches )
        {
            List<SwitchLog__c> previousRecords = [SELECT Id, StateStartTime__c, StateStopTime__c, 
                                                  RelaySwitch__c, ActionAtStateStart__c FROM SwitchLog__c
                                                  where RelaySwitch__c=:switchToggled.Id and StateStopTime__c=null];
            Datetime currentInstance = System.now();
            if(previousRecords.size()>1)// Exception Scenario . Handle here
            {
                
            }
            else if(previousRecords.size()==1) // Normal scenario after first usage
            {
                
                previousRecords[0].StateStopTime__c=currentInstance;
                update previousRecords;// Using update withing loop is probably not a good idea. Bulkify the functionality later.
                
            }
            
            SwitchLog__c logRecord = new SwitchLog__c(
                StateStartTime__c=currentInstance,RelaySwitch__c=switchToggled.Id, ActionAtStateStart__c=switchToggled.Status__c);
            newRecords.add(logRecord);
            
        }
        insert newRecords;
        
    }
    
    
}