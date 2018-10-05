public class NewCaseListController {
    
    public List<Case> getNewCases()
    {
        List<Case> results = Database.query(
            'select id,status,case.account.name from case where id <>null and'+
            ' CaseNumber <> null and status=\'new\'');
        return results;
    }
}