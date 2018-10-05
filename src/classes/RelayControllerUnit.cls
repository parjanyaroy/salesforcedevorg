public class RelayControllerUnit {
    
    /**
     * Author: Parjanya Roy
     * Called during Init from the RelayControllerComponent
     * Fetches all the child switches of a parent relay
     */
    @AuraEnabled
    public static List<RelaySwitch__c > getSwitches(Id relayId) {
        return [Select Id, Name ,Wattage__c,LastTurnedOn__c,Status__c  From RelaySwitch__c  Where Relay__c = :relayId];
    }

    /**
     * Author: Parjanya Roy
     * Use this method for basic switch ON/OFF operation.
     * This method DOES NOT involve scheduled usage and makes a direct call to the DeviceCallout.
     */
	@AuraEnabled
	public static List<String> changeSwitchState(String switchId,boolean requestedState)    
    {
        List<String> resultMessage = new List<String>();
    	System.debug('switchId '+switchId+' requestedState '+requestedState);
        //RelaySwitch__c requestedSwitch = new RelaySwitch__c(Id=switchId);
        RelaySwitch__c requestedSwitch = [SELECT Id, Relay__c,Relay__r.Operating_Mode__c, SwitchNumber__c, Status__c, Name FROM RelaySwitch__c where Id=:switchId];
        if(requestedState==true)
        {
            requestedSwitch.LastTurnedOn__c=System.now();
        }
        requestedSwitch.Status__c= requestedState==false? 'POWER OFF' : 'POWER ON' ;
        String returnToast='';
        String requestType = requestedState? 'ON' : 'OFF';
        try
        {
            boolean response=DeviceCallout.callDevice(switchId, requestType);
            if(response)
            {
            update requestedSwitch;
            returnToast='Switch Status Changed To '+requestedSwitch.Status__c;
            resultMessage.add('success');
            resultMessage.add(returnToast);
            }
            else
            {
            Relay__c parentRelay = new Relay__c(Id=requestedSwitch.Relay__c);
            if(requestedSwitch.Relay__r.Operating_Mode__c=='Cloud-Sync')
            {
                update requestedSwitch;
                resultMessage.add('warning');
                returnToast='Device Unreachable . Switch Updated with CLOUD_SYNC will be reflected on next boot.Updated Value '+requestedSwitch.Status__c;
            }
            else
            {
                resultMessage.add('error');
            	returnToast='Device Unreachable! Cannot update switch To '+requestedSwitch.Status__c;    
            }
            parentRelay.NetworkFailureRecorded__c=true;
			update parentRelay;          
            
            resultMessage.add(returnToast);
            }
            
        }
        catch(Exception e)
        {
            returnToast='Error Changing Switch Status To '+requestedSwitch.Status__c;
            resultMessage.add('error');
            resultMessage.add(returnToast);
            
        }
        
        return resultMessage;
    }
    
    @AuraEnabled
    public static List<RelaySwitch__c> getAllRelaysForSocket(Id HADeviceId){
        //List<Relay__c> lstRelays = new List<Relay__c>();
        List<RelaySwitch__c> lstRelaySwitches = new List<RelaySwitch__c>();
        Integer numberOfRSwitches;
        for(List<Relay__c> rList : [select Id ,(SELECT Id, Name, Status__c from RelaySwitches__r) from Relay__c WHERE 	HADevice__c = :HADeviceId]){
            //lstRelays.add(rList);
            for(Relay__c relay : rList){
                numberOfRSwitches = relay.RelaySwitches__r.size();
                for(Integer i = 0; i<numberOfRSwitches; i++){
                    RelaySwitch__c rSwitch = new RelaySwitch__c();
                    rSwitch.Id = relay.RelaySwitches__r[i].Id;
                    rSwitch.Name = relay.RelaySwitches__r[i].Name;
                    rSwitch.Status__c = relay.RelaySwitches__r[i].Status__c;
                    lstRelaySwitches.add(rSwitch);
                }
            }
        }
        System.debug('Switches - '+lstRelaySwitches);
        return lstRelaySwitches;
    }
}