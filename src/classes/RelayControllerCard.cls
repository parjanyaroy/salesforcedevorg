public class RelayControllerCard {
    
     /**
     * Author: Parjanya Roy
     * Called during Init from the RelayControllerCard
     * Fetches all required parameters
     */
    @AuraEnabled
    public static Relay__c getRelayAttributes(Id relayId) {
        return [SELECT Id, Operating_Mode__c, NetworkFailureRecorded__c FROM Relay__c  Where Id = :relayId];
    }


}