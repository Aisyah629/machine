package aspectj.data.processor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public aspect LoggingAspect {

    // Define a pointcut for all methods in DataProcessor
    pointcut processDataMethodCall() : execution(* aspectj.data.processor.DataProcessor.process*());

    pointcut validateDataMethodCall() : execution(* aspectj.data.processor.DataProcessor.validateData());

    pointcut transformDataMethodCall() : execution(* aspectj.data.processor.DataProcessor.transformData());

    before() : processDataMethodCall() {
        logBefore("Processing Data");
    }

    before() : validateDataMethodCall() {
        logBefore("Validating Data");
    }

    before() : transformDataMethodCall() {
        logBefore("Transforming Data");
    }

    after() : processDataMethodCall() {
        logAfter("Processing Data");
    }

    after() : validateDataMethodCall() {
        logAfter("Validating Data");
    }

    after() : transformDataMethodCall() {
        logAfter("Transforming Data");
    }

    private void logBefore(String operation) {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        System.out.println("[" + timestamp + "] BEFORE " + operation);
    }

    private void logAfter(String operation) {
        String timestamp = LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        System.out.println("[" + timestamp + "] AFTER " + operation);
    }
}
