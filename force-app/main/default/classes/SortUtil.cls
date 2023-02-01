public with sharing class SortUtil implements Comparable {

    public enum SortOrder { ASCENDING, DESCENDING }
    public enum Type { TYPE_STRING, TYPE_INTEGER, TYPE_DECIMAL }

    Object record;
    SortOrder sortOrderValue;
    String fieldName;
    Type valueType;

    public SortUtil(Object record, SortOrder sortOrderValue, String fieldName, Type valueType) {
        this.record = record;
        this.sortOrderValue = sortOrderValue;
        this.fieldName = fieldName;
        this.valueType = valueType;
    }

    public Integer compareTo(Object anotherObject) {
        String pSerializedAnotherRecord = JSON.serialize(((SortUtil) anotherObject).record);
        Map<String,Object> anotherRecord = (Map<String,Object>) JSON.deserializeUntyped(pSerializedAnotherRecord);

        String pSerializedRecord = JSON.serialize(record);
        Map<String,Object> currentRecord = (Map<String,Object>) JSON.deserializeUntyped(pSerializedRecord);

        if(valueType.equals(Type.TYPE_STRING)) {
            return compareStrings((String) currentRecord.get(fieldName), (String) anotherRecord.get(fieldName));
        } else if(valueType.equals(Type.TYPE_INTEGER)) {
            return compareIntegers((Integer) currentRecord.get(fieldName), (Integer) anotherRecord.get(fieldName));
        } else if(valueType.equals(Type.TYPE_DECIMAL)) {
            return compareDecimals((Decimal) currentRecord.get(fieldName), (Decimal) anotherRecord.get(fieldName));
        }
        return -1;
    }

    public Integer compareStrings(String sourceValue, String destinationValue) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
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


    public Integer compareIntegers(Integer sourceValue, Integer destinationValue) {
        SYSTEM.DEBUG(sourceValue);
        SYSTEM.DEBUG(destinationValue);
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    public Integer compareDecimals(Decimal sourceValue, Decimal destinationValue) {
        if(sortOrderValue.equals(SortOrder.ASCENDING)) {
            if(sourceValue < destinationValue) {
                return -1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return 1;
            }
        } else {
            if(sourceValue < destinationValue) {
                return 1;
            } else if(sourceValue == destinationValue) {
                return 0;
            } else {
                return -1;
            }
        }
    }

    public static void sortRecords(List<Object> records, SortOrder sortOrderValue, String fieldName, Type valueType) {
        List<SortUtil> sortUtils = new List<SortUtil>();
        for(Object record : records) {
            sortUtils.add(new SortUtil(record, sortOrderValue, fieldName, valueType));
        }
        sortUtils.sort();
        records.clear();
        for(SortUtil sortUtil : sortUtils) {
            records.add(sortUtil.record);
        }
    }
}