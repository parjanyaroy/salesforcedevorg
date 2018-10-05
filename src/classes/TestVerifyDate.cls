@isTest
private class TestVerifyDate {
    
    private static Date dateRef;
    private static Date date2;
    private static Date date3;
    private static Date date4;
    
    

    @isTest
    static void CheckDatesTest1()
    {
        dateRef= Date.newInstance(2018, 6, 12);
        date2= Date.newInstance(2018, 6, 13);
        System.debug('dateRef '+dateRef+' date2 '+date2);
        Date resultDate=VerifyDate.CheckDates(dateRef,date2); // Within next 30 days
        System.assertEquals(date2, resultDate);
    }
    @isTest
    static void CheckDatesTest2()
    {
        dateRef= Date.newInstance(2018, 6, 12);
        date3= Date.newInstance(2018, 8, 12);
        System.debug('dateRef '+dateRef+' date3 '+date3);
        Date resultDate=VerifyDate.CheckDates(dateRef,date3); // Beyond next 30 days
        System.assertEquals(Date.newInstance(2018, 6, 30), resultDate);
    }
    @isTest
    static void CheckDatesTest3()
    {
        dateRef= Date.newInstance(2018, 6, 12);
        date4= Date.newInstance(2018, 5, 12);
        Date resultDate=VerifyDate.CheckDates(dateRef,date4); // Previous Date
    }
   

}