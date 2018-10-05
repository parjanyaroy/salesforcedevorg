public class DeviceRegistrationTriggerHandler {
    
    public static void registrationSetup(List<HADevice__c> registeredDevices)
    {
        // Set Registration Date in The Parent HADevice__c
        setRegistrationDate(registeredDevices);
        // Create Single Relay For All HA_Device
        List<Relay__c> relayMasterList = new List<Relay__c>();
        for(HADevice__c device : registeredDevices)
        {
            Relay__c relayMaster = new Relay__c(HADevice__c=device.Id);
            relayMasterList.add(relayMaster);
        }
        insert relayMasterList;
        List<RelaySwitch__c> relaySwitchList = new List<RelaySwitch__c>();
        for(Relay__c singleMasterRelay : relayMasterList)
        {
            RelaySwitch__c switch1 = new RelaySwitch__c(name='Switch-1',SwitchNumber__c='SW1',relay__c=singleMasterRelay.Id);
            RelaySwitch__c switch2 = new RelaySwitch__c(name='Switch-2',SwitchNumber__c='SW2',relay__c=singleMasterRelay.Id);
            RelaySwitch__c switch3 = new RelaySwitch__c(name='Switch-3',SwitchNumber__c='SW3',relay__c=singleMasterRelay.Id);
            RelaySwitch__c switch4 = new RelaySwitch__c(name='Switch-4',SwitchNumber__c='SW4',relay__c=singleMasterRelay.Id);
            relaySwitchList.add(switch1);
            relaySwitchList.add(switch2);
            relaySwitchList.add(switch3);
            relaySwitchList.add(switch4);
        }
        insert relaySwitchList;
        
    }
    
    private static void setRegistrationDate(List<HADevice__c> registeredDevices)
    {
        for(HADevice__c device : registeredDevices)
        {
            device.RegistrationDate__c = System.today();
        }
    }
    
    
    
    
}