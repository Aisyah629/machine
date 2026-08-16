import java.util.HashMap;
import java.util.Map;

public aspect PerformanceMonitor {

    private Map<String, Long> executionTimes = new HashMap<>();
    private int methodCount = 0;

    pointcut monitoredMethods():
        execution(* @Monitor *.*(..));

    before(): monitoredMethods() {
        System.out.println("[PRE] Entering method: " + thisJoinPoint.getSignature().toShortString());
    }

    after(): monitoredMethods() {
        String methodName = thisJoinPoint.getSignature().toShortString();
        long startTime = executionTimes.getOrDefault(methodName, 0L);
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        executionTimes.put(methodName, endTime);
        methodCount++;
        System.out.println("[POST] Method: " + methodName + " completed in " + duration + "ms.");
        System.out.println("[INFO] Total methods monitored: " + methodCount);
    }

    around(): monitoredMethods() {
        long startTime = System.currentTimeMillis();
        executionTimes.put(thisJoinPoint.getSignature().toShortString(), startTime);
        return proceed();
    }
}
