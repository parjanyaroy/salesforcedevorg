@isTest
public class AnimalLocatorTest {
    @isTest 
    public static void testGetCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        String animalName = AnimalLocator.getAnimalNameById(2);
        System.assertEquals('bear', animalName);
    }
}