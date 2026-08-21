package aspectj.data.processor;

public aspect ValidationAspect {

    // Pointcut for validateData method
    pointcut validatePointcut() : execution(* aspectj.data.processor.DataProcessor.validateData());

    // Pointcut for processNextRecord method
    pointcut processRecordPointcut() : execution(* aspectj.data.processor.DataProcessor.processNextRecord());

    before() : validatePointcut() {
        System.out.println("[ValidationAspect] Pre-validation check...");
    }

    before() : processRecordPointcut() {
        System.out.println("[ValidationAspect] Validating current record...");
    }

    after() : validatePointcut() {
        System.out.println("[ValidationAspect] Post-validation confirmation.");
    }
}
