public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer numstrings)
    {	
        List<String> stringlist = new List<String>();
        for(Integer i=0;i<numstrings;i++)
            stringlist.add('Test '+i);
        return stringlist;
    }
}