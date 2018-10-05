public class DeviceCallout {
    /*
* This class will be used for all callouts to the device , both in scheduled calls and in direct calls.
* For scheduled calls this will get invoked only at the specified time.For normal operations this will
* be invoked directly
*/
    
    public static boolean callDevice(String switchId,String requestedStatus)
    {
        /*
* 1.Get the switch name from the switch id to append to the call
* 2.Navigate to the parent relay and then to the parent device to get the device Id and endpoint url
* 3.Use the device endpoint url to create the request . Append the switch name and status in the end
*/
        try
        {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            //RelaySwitch__c SwitchRequested = new RelaySwitch__c(Id='switchId');
            RelaySwitch__c SwitchRequested = [Select Id,Relay__c,Relay__r.DeviceEndPointUrl__c,SwitchNumber__c from RelaySwitch__c where Id=:switchId ];
            String endPointUrl = SwitchRequested.Relay__r.DeviceEndPointUrl__c;
            System.debug('endPointUrl '+endPointUrl);
            String switchNumber = '';
            Switch on SwitchRequested.SwitchNumber__c{
                when 'SW1'{switchNumber='/5/';}
                when 'SW2'{switchNumber='/4/';}
                when 'SW3'{switchNumber='/0/';}
                when 'SW4'{switchNumber='/2/';}
            }
            requestedStatus= requestedStatus=='ON'?'on':'off';
            String requestUrl=endPointUrl+switchNumber+requestedStatus;
            System.debug('requestUrl '+requestUrl);
            request.setEndpoint(requestUrl);
            request.setMethod('GET');
            HttpResponse response = http.send(request);
            if(response.getHeader(SwitchRequested.SwitchNumber__c)!=requestedStatus)
                return false;
        }
        catch(Exception e)
        {
            System.debug('EXCEPTION '+e.getMessage()+' '+e.getStackTraceString());
            return false;
        }
        return true; // return after contacting device.If found false reschedule immediately.
    }
    
    
}