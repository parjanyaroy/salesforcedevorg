public class NewControllerForContact {
    // controller should be always static 
    @AuraEnabled
    public static String addNewContact(String firstName,String lastName, String email , String aboutMyself,Date myDOB)
    {
        Contact newContact= new Contact();
        newContact.DetailsAboutMe__c=aboutMyself;
        newContact.Birthdate=myDOB;
        newContact.FirstName=firstName;
        newContact.LastName=lastName;
        newContact.Email=email;
        //NewControllerForContact.WrapperContact objWrapper = new NewControllerForContact.WrapperContact();
        //objWrapper.firstName=firstName;
        
        insert newContact;
        return newContact.Id;
    }
    
    // controller should be always static 
    @AuraEnabled
    public static String addNewContactUsingWrapper(String wrapperObject)
    {	
        Type customWrapperType = Type.forName('NewControllerForContact.WrapperContact');
        Contact newContact= new Contact();
        System.debug('WO-> '+wrapperObject);
        NewControllerForContact.WrapperContact contactObject =(NewControllerForContact.WrapperContact)JSON.deserialize(wrapperObject,customWrapperType);
        newContact.DetailsAboutMe__c=contactObject.aboutMyself;
        newContact.Birthdate=contactObject.myDOB;
        newContact.FirstName=contactObject.firstName;
        newContact.LastName=contactObject.lastName;
        newContact.Email=contactObject.email;
        insert newContact;
        return newContact.Id;
    }
    
   
    @AuraEnabled
    public static List<Contact> getContacts() {
        List<Contact> cList=[select Name,Email,Birthdate from Contact];
        System.debug('-------->'+cList.size());
        return cList;
    }
    
    @AuraEnabled
    public static String getValues()
    {
       System.debug('NewControllerForContact :: getValues');
       NewControllerForContact.WrapperContact objWrapper = new NewControllerForContact.WrapperContact('a','b','c','d',null);
       return JSON.serialize(objWrapper) ;
    }
    
    
     //@AuraEnabled
    public static List<Schema.PicklistEntry> getPicklistValues()
    {
       System.debug('NewControllerForContact :: getValues');
       List<Schema.PicklistEntry> listPicklistValues = Account.AccountSource.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry entry : listPicklistValues)
        {
            System.debug(entry);
        }
        return listPicklistValues;
    } 
    
    public class WrapperContact{
        @AuraEnabled
        String firstName {get;set;}
        @AuraEnabled
        String lastName {get;set;}
        @AuraEnabled
        String email {get;set;}
        @AuraEnabled
        String aboutMyself {get;set;}
        @AuraEnabled
        Date myDOB {get;set;}
        
    
    public WrapperContact(String firstName,String lastName, String email , String aboutMyself,Date myDOB)
    {
        this.firstName=firstName;
        this.lastName=lastName;
        this.email=email;
        this.aboutMyself=aboutMyself;
        this.myDOB=myDOB;
    }
    }
}