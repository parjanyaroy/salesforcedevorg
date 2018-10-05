public class CustomSortingController {
 
   @AuraEnabled
   public static list <Contact> fetchContact(String sortField, boolean isAsc) {
      String sSoql = 'SELECT firstName, LastName, Department, MobilePhone ';
      sSoql += 'From Contact where firstName <>\'\' and department<>\'\' and mobilephone<>\'\' ';
      if (sortField != '') {
         sSoql += ' order by ' + sortField;
         if (isAsc) {
            sSoql += ' asc';
         } else {
            sSoql += ' desc';
         }
      }
      sSoql += ' LIMIT 10000';
      list <contact> lstResult;
      try {
         system.debug('The query is' + sSoql);
         lstResult = Database.query(sSoql);
         List < contact > returnConList = new List < contact > ();
 
         for (contact c: lstResult) {
            returnConList.add(c);
          }
         return returnConList;
      } 
      catch (Exception ex) {
         // for handle Exception
         return null;
      }
   }
 
}