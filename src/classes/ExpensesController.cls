public  with sharing class ExpensesController {
/*“Aura” is the name of the open source framework at the core of Lightning Components. 
* You’ve seen it used in the namespace for some of the core tags, such as <aura:component>.
*  Now you know where it comes from.The static keyword. All @AuraEnabled controller methods 
* must be static methods, and either public or global scope.
*/      
    @AuraEnabled
    public static List<Expense__c> getExpenses() {
        return [SELECT Id, Name, Amount__c, Client__c, Date__c, 
                Reimbursed__c, CreatedDate 
                FROM Expense__c];
    }
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        // Perform isUpdatable() checking first, then
        upsert expense;
        return expense;
    }
}