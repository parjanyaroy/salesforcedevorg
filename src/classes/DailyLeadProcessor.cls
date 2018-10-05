global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leadList = [SELECT LeadSource  
                                    FROM Lead 
                                    WHERE LeadSource=null LIMIT 200];
        for(Lead l1 : leadList)
        {
            l1.LeadSource='Dreamforce';
        }
        update leadList;
      }
}