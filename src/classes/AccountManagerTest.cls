@isTest(SeeAllData=true)
private class AccountManagerTest {
	
	@isTest static void test_method_one() {
	
	RestRequest request = new RestRequest();
        request.requestUri =
            'https://parjanyaroy-dev-ed.lightning.force.com/services/apexrest/Accounts/'
            + '0017F00000lJhXwQAK'+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account accountNew = AccountManager.getAccount();
        // Verify results
        System.assert(accountNew != null);
        
	}
	
	
}