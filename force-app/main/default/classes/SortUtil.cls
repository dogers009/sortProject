public with sharing class SortUtil implements Comparable {

    Object record;
    String sortOrderValue;
    String fieldName;

    public SortUtil(Object record, String sortOrderValue, String fieldName) {
        this.record = record;
        this.sortOrderValue = sortOrderValue;
        this.fieldName = fieldName;
    }

    public Integer compareTo(Object anotherObject) {
        String pSerializedAnotherRecord = JSON.serialize(((SortUtil) anotherObject).record);
        Map<String,Object> anotherRecord = (Map<String,Object>) JSON.deserializeUntyped(pSerializedAnotherRecord);

        String pSerializedRecord = JSON.serialize(record);
        Map<String,Object> currentRecord = (Map<String,Object>) JSON.deserializeUntyped(pSerializedRecord);
        List<String> fields = fieldName.split(',');
        List<String> sortOrder = sortOrderValue.split(',');
        Integer loopCount = 0;
        for(String f : fields){
            system.debug(f);
            string order = sortOrder[loopCount];
            system.debug(order);
            loopCount++;
                return compare(string.valueof(currentRecord.get(f)),string.valueof(anotherRecord.get(f)),order);
 
        }
       
        return -1;
    }
    public Integer compare(String sourceValue, String destinationValue,String SortOrder) {
        if(sortOrderValue.equals('ASCENDING')) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue.equals(destinationValue)) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue.equals(destinationValue)) {
                return 0;
            } else {
                return -1;
            }
        }
    }
    public static void sortRecords(List<Object> records, String sortOrderValue, String fieldName) {
        List<SortUtil> sortUtils = new List<SortUtil>();
        for(Object record : records) {
            sortUtils.add(new SortUtil(record, sortOrderValue, fieldName));
        }
        sortUtils.sort();
        records.clear();
        for(SortUtil sortUtil : sortUtils) {
            records.add(sortUtil.record);
        }
    }
}