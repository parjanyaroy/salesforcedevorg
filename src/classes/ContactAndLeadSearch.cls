public class ContactAndLeadSearch {

    public static List<List< SObject>> searchContactsAndLeads(String parameter)
    {
       // It should then find any contact or lead that matches the string as 
       // part of either the first or last name
		List<List<sObject>> searchList = [FIND :parameter IN ALL FIELDS 
                   RETURNING Contact(firstName,lastname),Lead(FirstName,LastName)];
        return searchList;
    }
}