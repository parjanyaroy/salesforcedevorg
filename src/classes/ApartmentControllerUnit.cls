public class ApartmentControllerUnit {
    
    @AuraEnabled
    public static List<Room__c> getAllRoomsList(Id apartmentId) {
        System.debug('debug SwitchControllerUnit : getSwitches : roomId '+apartmentId);
        return [Select Id, Name  From Room__c Where Apartment__c = :apartmentId];
    }

}