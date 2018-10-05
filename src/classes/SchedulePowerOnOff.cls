global class SchedulePowerOnOff implements Schedulable {
    
    // This class is used to schedule calls to the DeviceCallout class.    
    public  String switchId ;
    public  String requestedAction ;
    
    public String POWER_ON_DEVICE='ON';
    public String POWER_OFF_DEVICE='OFF';
    
    global void execute(SchedulableContext SC) {
        if(requestedAction=='ON')
        {
            DeviceCallout.callDevice(switchId, POWER_ON_DEVICE);
        }
        else
        {
            DeviceCallout.callDevice(switchId, POWER_ON_DEVICE);
        }
    }
    public SchedulePowerOnOff(String switchId,String requestedAction)
    {
        this.switchId=switchId;   
        this.requestedAction=requestedAction;
    }
    
}