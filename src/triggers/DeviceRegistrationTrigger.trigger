trigger DeviceRegistrationTrigger on HADevice__c (before update) {
    if(Trigger.isBefore)
    {
        if(Trigger.isUpdate)
        {
            Map<Id,HADevice__c> afterUpdateDevice = Trigger.newMap;
            Map<Id,HADevice__c> beforeUpdateupdatedDevice = Trigger.oldMap;
            List<HADevice__c> registeredDevices = new List<HADevice__c>();
            for(Id objectId : afterUpdateDevice.keySet() )
            {
                if(afterUpdateDevice.get(objectId).Status__c=='Registered' 
                   && beforeUpdateupdatedDevice.get(objectId).Status__c!='Registered')
                {
                    registeredDevices.add(afterUpdateDevice.get(objectId));
                }
            }
            Set<HADevice__c> alreadyRelayCreated = new Set<HADevice__c>();
            if(registeredDevices.size()>0)
            {
                DeviceRegistrationTriggerHandler.registrationSetup(registeredDevices);
            }
        }
    }
}