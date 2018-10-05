global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator  start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select LeadSource from Lead');
    }
    global void execute(Database.BatchableContext bc, List<Lead> records){
        List<Lead> l1 = new List<Lead>();
        for(Lead lead : records)
        {
            lead.LeadSource='Dreamforce';
            l1.add(lead);
        }
        update l1;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}