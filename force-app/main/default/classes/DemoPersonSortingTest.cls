@isTest
private class DemoPersonSortingTest {
   public enum gender { WOMAN, MAN }
   static testMethod void testPersonSortOption1(){
    
        Person p1 = new Person();
        p1.firstName = 'firstName Test 1';
        p1.lastName = 'lastName Test 1';
        p1.gender = string.valueOf(gender.MAN);
        p1.age = 21;

        Person p2 = new Person();
        p2.firstName = 'firstName Test 2';
        p2.lastName = 'lastName Test 2';
        p2.gender = string.valueOf(gender.WOMAN);
        p2.age = 22;

        Person p3 = new Person();
        p3.firstName = 'firstName Test 3';
        p3.lastName = 'lastName Test 3';
        p3.gender = string.valueOf(gender.WOMAN);
        p3.age = 45;

        List<Person> persons = new List<Person>();
        persons.add(p1);
        persons.add(p2);
        persons.add(p3);
       
        //Person sort option 1
        
        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'age', SortUtil.Type.TYPE_INTEGER);
        system.assertEquals(persons[0], p1,'age ASCENDING');

        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'gender', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p1,'WOMEN FIRST');
       	system.assertEquals(persons[1], p2,'WOMEN FIRST');
       
        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'firstName', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p1,'fisrName ASCENDING');

        SortUtil.sortRecords(persons , SortUtil.SortOrder.DESCENDING, 'lastName', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p3,'lastName DESCENDING');
        
       
        //Person sort option 2
        
        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'gender', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p1,'gender ASCENDING');
        
        SortUtil.sortRecords(persons , SortUtil.SortOrder.DESCENDING, 'firstName', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p3,'fisrName DESCENDING');

        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'lastName', SortUtil.Type.TYPE_STRING);
        system.assertEquals(persons[0], p1,'lastName ASCENDING');
       
        SortUtil.sortRecords(persons , SortUtil.SortOrder.ASCENDING, 'age', SortUtil.Type.TYPE_INTEGER);
        system.assertEquals(persons[0], p1,'age ASCENDING');

   }
   
}