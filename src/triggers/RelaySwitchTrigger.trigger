trigger RelaySwitchTrigger on RelaySwitch__c (after update) {
 if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            
            Map<Id,RelaySwitch__c> afterUpdateSwitches = Trigger.newMap;
            Map<Id,RelaySwitch__c> beforeUpdateSwitches = Trigger.oldMap;
            List<RelaySwitch__c> toggledSwitches = new List<RelaySwitch__c>();
            for(Id objectId : afterUpdateSwitches.keySet() )
            {
                if(afterUpdateSwitches.get(objectId).Status__c=='POWER OFF' 
                   && beforeUpdateSwitches.get(objectId).Status__c!='POWER OFF')
                {
                    toggledSwitches.add(afterUpdateSwitches.get(objectId));
                }
                else if(afterUpdateSwitches.get(objectId).Status__c=='POWER ON' 
                   && beforeUpdateSwitches.get(objectId).Status__c!='POWER ON')
                {
                    toggledSwitches.add(afterUpdateSwitches.get(objectId));
                }
            }
            if(toggledSwitches.size()>0)
            {
                RelaySwitchTriggerHandler.createLogEvent(toggledSwitches);
            }
            
            
        }
    }
}