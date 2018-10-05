public class RelayTriggerHandler {
    public static void createLogEventForNetworkOutageStart(List<Relay__c> toggledRelays)
    {
        List<SwitchLog__c> newRecords = new List<SwitchLog__c>();
        for(Relay__c relayToggled : toggledRelays )
        {
            List<SwitchLog__c> previousRecords = [SELECT Id, StateStartTime__c, StateStopTime__c, 
                                                  RelaySwitch__c,RelaySwitch__r.Relay__c, ActionAtStateStart__c FROM SwitchLog__c
                                                  where RelaySwitch__r.Relay__c=:relayToggled.Id and StateStopTime__c=null];
            Datetime currentInstance = System.now();
            for(SwitchLog__c log : previousRecords)
            {
                log.StateStopTime__c=currentInstance;
                SwitchLog__c logRecord = new SwitchLog__c(
                StateStartTime__c=currentInstance,RelaySwitch__c=log.RelaySwitch__c, ActionAtStateStart__c='NETWORK FAILURE');
                newRecords.add(logRecord);
            }
            update previousRecords;
        }
        insert newRecords;
    }
    
    public static void createLogEventForNetworkOutageEnd(List<RelaySwitch__c> toggledRelaySwitches)
    {
        Set<Id> recoveredSwithchesId = new Set<Id>();
        for(RelaySwitch__c sw:toggledRelaySwitches)
        {
            recoveredSwithchesId.add(sw.Id);
        }
        List<SwitchLog__c> newRecords = new List<SwitchLog__c>();
        List<SwitchLog__c> previousRecords = [SELECT Id, StateStartTime__c, StateStopTime__c, 
                                                  RelaySwitch__c,RelaySwitch__r.Relay__c ,RelaySwitch__r.Status__c, ActionAtStateStart__c FROM SwitchLog__c
                                                  where RelaySwitch__c IN  :recoveredSwithchesId and StateStopTime__c=null and 
                                                 ActionAtStateStart__c='NETWORK FAILURE' ];
            Datetime currentInstance = System.now();
            for(SwitchLog__c log : previousRecords)
            {
                log.StateStopTime__c=currentInstance;
                SwitchLog__c logRecord = new SwitchLog__c(
                StateStartTime__c=currentInstance,RelaySwitch__c=log.RelaySwitch__c, ActionAtStateStart__c=log.RelaySwitch__r.Status__c);
                newRecords.add(logRecord);
            }
            update previousRecords;
        insert newRecords;
        }
        
        
    }