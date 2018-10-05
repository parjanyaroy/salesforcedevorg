@RestResource(urlMapping = '/iotservice')
global class RealTimeDataService {
    
    public static final String DATE_API_KEY = 'RKEX6GHOJMTH';
    public static final Integer VALIDITY_TIME_LIMIT = 1 ;
    
    @HttpGet
    global static void doGet() {
        RestContext.response.addHeader('Content-Type', 'text/plain');
        //RestContext.response.addHeader('Content-Type', 'application/json');
        String fetchedDeviceId = RestContext.request.params.get('DeviceId');
        fetchedDeviceId=fetchedDeviceId.trim();
        try {
            if(fetchedDeviceId.length()>0)
            {
                Integer apiTimeStamp = getTimestamp();
                List<String> deviceData=decodeId(fetchedDeviceId);
                if(apiTimeStamp-(Integer.valueOf(deviceData[1]))>=VALIDITY_TIME_LIMIT)
                {
                    RestContext.response.responseBody = Blob.valueOf('DEVICE_TOKEN_EXPIRED');
                }
                List<HADevice__c> devices = [Select Id,Status__c from HADevice__c 
                                             where DeviceId__c=:deviceData[0]];
                List<RelaySwitch__c> switches = [Select Status__c,Relay__r.NetworkFailureRecorded__c ,Relay__r.Operating_Mode__c from RelaySwitch__c where Relay__r.HADevice__r.DeviceId__c=:deviceData[0]];
                if(devices.size()==1)
                {
                    switch on devices[0].status__c {
                        when 'Inactive' {
                            // First Time Communication From Device . Change status to active
                            devices[0].status__c='Active';
                            devices[0].activationDate__c=System.today();
                            update devices;
                            RestContext.response.responseBody = Blob.valueOf('DEVICE_ACTIVATED');
                            
                        }
                        when 'Registered' {
                            // Already registered and configured device is connecting to network . Update latest time.
                            String switchStatus=getSwitchConfigAtBoot(switches);
                            RestContext.response.responseBody = Blob.valueOf('DEVICE_ONLINE'+switchStatus);
                            
                            
                        }
                        when 'Active'    {
                            // Ignore call as device has been activated but not registered
                            RestContext.response.responseBody = Blob.valueOf('DEVICE_UNREGISTERED');
                        }
                    }
                }
                else if(devices.size()==0)
                {
                    RestContext.response.responseBody = Blob.valueOf('DEVICE_INVALID');
                }
                else
                {
                    RestContext.response.responseBody = Blob.valueOf('DEVICE_DUPLICATE_EXCEPTION');
                    // Notify Admin
                }
            }
            else
            {
                RestContext.response.responseBody = Blob.valueOf('DEVICE_PARAMETER_INVALID');
            }
        } catch (Exception ex) {
            RestContext.response.responseBody = Blob.valueOf('DEVICE_EXCEPTION'+ex.getMessage()+':::'+ex.getStackTraceString()+'<<');
        }
    }
    
    private static String[] decodeId(String encodedId)
    {	List<String> results = new List<String>();
     if(encodedId.length()>20)
     {
         String result=encodedId ;
         result=result.replace('s','0');
         result=result.replace('u','1');
         result=result.replace('c','2');
         result=result.replace('h','3');
         result=result.replace('a','4');
         result=result.replace('n','5');
         result=result.replace('d','6');
         result=result.replace('r','7');
         result=result.replace('p','8');
         result=result.replace('l','9');
         String deviceId = result.substring(0,20);
         String timeStamp= result.substring(20);
         results.add(deviceId);
         results.add(timeStamp);
     }
     return results;
    }
    
    private static Integer getTimestamp()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://api.timezonedb.com/v2/get-time-zone?key='+DATE_API_KEY+'&format=json&by=zone&zone=Asia/Kolkata');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return (Integer)results.get('timestamp');
            
        }
        else
            return 0;
        
    }
    
    private static String getSwitchConfigAtBoot(List<RelaySwitch__c> switches)
    {
        String switchStatus='';
    if(switches[0].Relay__r.NetworkFailureRecorded__c)
    {
        if(switches[0].Relay__r.Operating_Mode__c=='Cloud-Sync')
        {
            switchStatus=':'+switches[0].Status__c+':'+switches[1].Status__c+':'
                +switches[2].Status__c+':'+switches[3].Status__c;
        }
        else
        {
            switchStatus=':'+'POWER OFF'+':'+'POWER OFF'+':'+'POWER OFF'+':'+'POWER OFF';
            switches[0].Status__c='POWER OFF';
            switches[1].Status__c='POWER OFF';
            switches[2].Status__c='POWER OFF';
            switches[3].Status__c='POWER OFF';
            update switches;
        }
        Relay__c parentRelay=new Relay__c(Id=switches[0].Relay__c);
        parentRelay.NetworkFailureRecorded__c=false;
        update parentRelay;
    }
    else
    {
        switchStatus=':'+switches[0].Status__c+':'+switches[1].Status__c+':'
                +switches[2].Status__c+':'+switches[3].Status__c;
    }
        return switchStatus;
    }
    
    
}