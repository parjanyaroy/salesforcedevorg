@isTest
public class ParkLocatorTest {
	@isTest 
	static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        List<String> result = ParkLocator.country('India');
        // Verify that a fake result is returned
        System.assertEquals('A', result[0]); 
    }

}