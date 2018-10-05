public class ContactSearch {
    
    public static List<Contact> searchForContacts(String contactLastName,String postalCode)
    {
        return [select id,name from contact where lastname=:contactLastName and MailingPostalCode=:postalCode ];
    }

}