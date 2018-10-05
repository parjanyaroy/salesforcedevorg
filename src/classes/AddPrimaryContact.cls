public class AddPrimaryContact implements Queueable {
    
    String state;
   	Contact contact;
    
    public AddPrimaryContact(Contact contact,String state)
    {
        this.state=state;
        this.contact=contact;
		// sample comment
    }
    
    
    public void execute(QueueableContext context) {
        
       // List<Account> lst = [select Name from Account where BillingState =:state LIMIT 200];
       for(Account acc : [select Name from Account where BillingState =:state LIMIT 200] )
       {
           Contact clonedContact = contact.clone(true, true, true, true);
			insert clonedContact;
       }
        
    }
}