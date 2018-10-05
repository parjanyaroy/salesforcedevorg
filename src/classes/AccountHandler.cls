public class AccountHandler {
    
    public static Account insertNewAccount(String accountName)
    {
        Account acnt = new Account(name=accountName);
        Database.SaveResult result = Database.insert(acnt,false);
        if(result.isSuccess())
            return acnt;
        else
            return null;
        
    }

}