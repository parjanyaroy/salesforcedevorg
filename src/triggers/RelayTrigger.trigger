trigger RelayTrigger on Relay__c (after update) {
    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            
            Map<Id,Relay__c> afterUpdateRelay = Trigger.newMap;
            Map<Id,Relay__c> beforeUpdateRelay = Trigger.oldMap;
            List<Relay__c> toggledRelays = new List<Relay__c>();
            List<Relay__c> toggledRelaysAfterRecovery = new List<Relay__c>();
            for(Id objectId : afterUpdateRelay.keySet() )
            {
                if(afterUpdateRelay.get(objectId).NetworkFailureRecorded__c==true
                   && beforeUpdateRelay.get(objectId).NetworkFailureRecorded__c!=true)
                {
                    toggledRelays.add(afterUpdateRelay.get(objectId));
                }
                else if(afterUpdateRelay.get(objectId).NetworkFailureRecorded__c==false 
                        && beforeUpdateRelay.get(objectId).NetworkFailureRecorded__c!=false)
                {
                    toggledRelaysAfterRecovery.add(afterUpdateRelay.get(objectId));
                }
            }
            if(toggledRelays.size()>0)
            {
                RelayTriggerHandler.createLogEventForNetworkOutageStart(toggledRelays);
            }
            if(toggledRelaysAfterRecovery.size()>0)
            {
                List<RelaySwitch__c> switchRecovered = [SELECT Id, Relay__c, SwitchNumber__c, Wattage__c, LastTurnedOn__c, Status__c, Name FROM RelaySwitch__c
                                                       where Relay__c IN :toggledRelaysAfterRecovery];
                RelayTriggerHandler.createLogEventForNetworkOutageEnd(switchRecovered);
            }
            
             
        }
    }
}