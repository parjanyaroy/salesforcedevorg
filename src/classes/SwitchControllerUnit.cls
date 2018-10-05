public class SwitchControllerUnit {
    
    @AuraEnabled
    public static List<Switch__c> getSwitches(Id roomId) {
        System.debug('debug SwitchControllerUnit : getSwitches : roomId '+roomId);
        return [Select Id, Name , Room__c , isSwitchedOn__c , Wattage__c  From Switch__c Where Room__c = :roomId];
    }
    @AuraEnabled
    public static boolean setPowerOff(Id switchId)
    {
        try
        {
            System.debug('debug SwitchControllerUnit : setPowerOff : switchId '+switchId);
            List<Switch__c> switchList = [Select isSwitchedOn__c from Switch__c Where Id=:switchId limit 1];
            switchList[0].isSwitchedOn__c=false;
            update switchList;
            return true;
        }
        catch(Exception e)
        {
            // Log the executing class exception in a separate utility.
            System.debug('Exception : Occured In SwitchControllerUnit : setPowerOff ');
            return false;
        }
      }
    
    @AuraEnabled
    public static boolean setPowerOn(Id switchId)
    {
        try
        {
            List<Switch__c> switchList = [Select isSwitchedOn__c from Switch__c Where Id=:switchId limit 1];
            switchList[0].isSwitchedOn__c=true;
            update switchList;
            return true;
        }
        catch(Exception e)
        {
            // Log the executing class exception in a separate utility.
            System.debug('Exception : Occured In SwitchControllerUnit : setPowerOn ');
            return false;
        }
      }
    
}