public class RandomContactFactory {
    
    public static List<Contact> generateRandomContacts(Integer numContacts, String LastName) {
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0;i<numContacts;i++) {
            Contact c = new Contact(firstname='ABC'+i,lastName=LastName);
            contactList.add(c);
        }
        return contactList;
    }

}