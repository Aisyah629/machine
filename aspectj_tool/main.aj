import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * A sample AspectJ program demonstrating cross-cutting concerns,
 * logging, and execution tracing through dynamic code weaving.
 */
public aspect LoggingAspect {

    private static final Logger logger = Logger.getLogger(LoggingAspect.class.getName());

    // Define a pointcut that matches the execution of any public method
    pointcut publicMethodExecution(): execution(public * *(..));

    // Before advice: logs method entry
    before(): publicMethodExecution() {
        logger.info("Entering method: " + thisJoinPoint.getSignature());
    }

    // After returning advice: logs method exit
    after() returning: publicMethodExecution() {
        logger.info("Exited method: " + thisJoinPoint.getSignature());
    }

    // Around advice: measures method execution time
    Object around(): publicMethodExecution() {
        long startTime = System.currentTimeMillis();
        Object result = proceed(); // Proceeds with the actual method execution
        long endTime = System.currentTimeMillis();
        logger.info("Execution time for " + thisJoinPoint.getSignature() + ": " + (endTime - startTime) + " ms");
        return result;
    }

    // Catch advice: handles exceptions thrown by public methods
    after() throwing: publicMethodExecution() {
        logger.log(Level.WARNING, "Exception in method: " + thisJoinPoint.getSignature(), thisJoinPoint.getArgs()[0] instanceof Throwable ? (Throwable) thisJoinPoint.getArgs()[0] : null);
    }
}

/**
 * A sample target class to demonstrate the weaving of the LoggingAspect.
 */
class SampleService {

    public void performAction() {
        System.out.println("Performing a sample action...");
        // Simulate some processing
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public int calculate(int a, int b) {
        return a + b;
    }

    public void throwAnException() {
        throw new RuntimeException("Simulated exception!");
    }
}

/**
 * Main class to run the sample and observe the aspect weaving in action.
 */
public class Main {
    public static void main(String[] args) {
        SampleService service = new SampleService();
        
        System.out.println("--- Starting AspectJ Demo ---");
        service.performAction();
        System.out.println("Result of calculation: " + service.calculate(5, 3));
        
        try {
            service.throwAnException();
        } catch (Exception e) {
            System.out.println("Caught exception in main: " + e.getMessage());
        }
        
        System.out.println("--- Demo Finished ---");
    }
}
