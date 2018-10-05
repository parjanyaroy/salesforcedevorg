@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {

@HttpGet
global static Account getAccount() {
    System.debug('Hitting AccountManager');
    RestRequest request = RestContext.request;
    // grab the accountId from the end of the URL
    String accountId = request.requestURI.substringBetween('/Accounts/','/contacts');
    Account result =  [SELECT Id,Name,(Select Name from Contacts) FROM Account   WHERE Id = :accountId limit 1];
    return result;
}
}