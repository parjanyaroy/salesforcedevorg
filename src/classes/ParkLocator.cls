public class ParkLocator {

	public static String[] country(String countryName)
	{
		ParkService.ParksImplPort locator = new ParkService.ParksImplPort() ;
		return locator.byCountry(countryName);
	}

}