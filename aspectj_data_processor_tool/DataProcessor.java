package aspectj.data.processor;

public class DataProcessor {

    private String[] dataRecords;
    private int currentRecordIndex;

    public DataProcessor(String[] records) {
        this.dataRecords = records;
        this.currentRecordIndex = 0;
    }

    public void processNextRecord() {
        if (currentRecordIndex >= dataRecords.length) {
            System.out.println("End of data records reached.");
            return;
        }
        String record = dataRecords[currentRecordIndex];
        System.out.println("Processing record: " + record);
        currentRecordIndex++;
    }

    public void validateData() {
        System.out.println("Validating data integrity...");
        for (String record : dataRecords) {
            if (record == null || record.isEmpty()) {
                throw new IllegalArgumentException("Invalid data record: null or empty");
            }
        }
        System.out.println("Data validation passed.");
    }

    public void transformData() {
        System.out.println("Transforming data...");
        for (int i = 0; i < dataRecords.length; i++) {
            dataRecords[i] = dataRecords[i].toUpperCase();
        }
        System.out.println("Data transformation complete.");
    }

    public void reset() {
        currentRecordIndex = 0;
        System.out.println("Data processor reset.");
    }

    public int getCurrentRecordIndex() {
        return currentRecordIndex;
    }

    public int getTotalRecords() {
        return dataRecords.length;
    }

    public String getRecord(int index) {
        if (index < 0 || index >= dataRecords.length) {
            throw new IndexOutOfBoundsException("Invalid record index");
        }
        return dataRecords[index];
    }
}
