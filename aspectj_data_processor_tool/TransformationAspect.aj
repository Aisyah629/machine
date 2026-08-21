package aspectj.data.processor;

public aspect TransformationAspect {

    // Pointcut for transformData method
    pointcut transformPointcut() : execution(* aspectj.data.processor.DataProcessor.transformData());

    before() : transformPointcut() {
        System.out.println("[TransformationAspect] Pre-transform preparation...");
    }

    after() : transformPointcut() {
        System.out.println("[TransformationAspect] Post-transform verification...");
    }

    // Weaving advice to append metadata to processed records
    // This demonstrates aspectj's ability to modify behavior without changing code
    around() : execution(* aspectj.data.processor.DataProcessor.processNextRecord()) && call(* aspectj.data.processor.DataProcessor.getRecord(int)) {
        System.out.println("[TransformationAspect] Injecting metadata processing...");
        proceed();
        System.out.println("[TransformationAspect] Metadata processing complete.");
    }
}
