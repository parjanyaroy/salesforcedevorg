public class BusScheduleCache {
    
    private Cache.OrgPartition part;
    
    public BusScheduleCache()
    {
        part= Cache.Org.getPartition('local.BusSchedule');
    }
    
    public void putSchedule(String busLine, Time[] schedule)
    {
        part.put(busLine,schedule);
    }
    
    public Time[] getSchedule(String busLine)
    {
        List<Time> result = new List<Time>((Time[])part.get(busLine));
        //result=(Time[])part.get(busLine);
        if(result.size()==0)
        {
            result.add(Time.newInstance(8,0,0,0));
            result.add(Time.newInstance(17,0,0,0));
        }
        return result;
    }

}