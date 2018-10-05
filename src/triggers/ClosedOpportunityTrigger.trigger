trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
if(Trigger.isAfter)
{
    List<Task> newTasks = new List<Task>();
    for(Opportunity oppt : Trigger.New)
    {
        if(oppt.StageName=='Closed Won')
        {
            newTasks.add(new Task(subject='Follow Up Test Task',WhatId=oppt.Id));
        }
    }
    insert newTasks;
}
}