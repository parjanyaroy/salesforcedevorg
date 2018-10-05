@isTest
public class TestRestrictContactByName {
    @TestSetup
    private static void setup()
    {
        
    }
    @isTest
    private static void testInvalidInsert()
    {
        Test.startTest();
        Contact c1 = new Contact(LastName='INVALIDNAME');
        Database.SaveResult result;
        try
        {
       	result = Database.insert(c1);
        }
        catch(DmlException e)
        {
           System.assertEquals(e.getDmlMessage(0),'The Last Name "'+c1.LastName+'" is not allowed for DML');
        }
        
        
        Test.stopTest();
    }
    @isTest
    private static void testInvalidUpdate()
    {
        Contact c1 = new Contact(LastName='VALID');
        insert c1;
        c1.lastname='INVALIDNAME';
        Test.startTest();
        Database.SaveResult result;
        try
        {
       	result = Database.update(c1);
        }
        catch(DmlException e)
        {
           System.assertEquals(e.getDmlMessage(0),'The Last Name "'+c1.LastName+'" is not allowed for DML');
        }
        
        
        Test.stopTest();
    }
}