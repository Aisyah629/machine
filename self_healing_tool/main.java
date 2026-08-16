/**
 * Self-Healing Tool
 * Handles edge cases and errors with automatic recovery mechanisms.
 * 
 * @version 1.0
 * @date 2024-05-20
 */
public class SelfHealingSystem {
    private static final Logger logger = Logger.getLogger(SelfHealingSystem.class.getName());
    private final Map<String, Component> components;
    private final RecoveryStrategy recoveryStrategy;
    private volatile boolean isRunning;

    public SelfHealingSystem() {
        this.components = new ConcurrentHashMap<>();
        this.recoveryStrategy = new DefaultRecoveryStrategy();
        this.isRunning = false;
    }

    /**
     * Registers a component for monitoring and self-healing.
     * @param name The name of the component.
     * @param component The component instance.
     */
    public void registerComponent(String name, Component component) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Component name cannot be null or empty");
        }
        if (component == null) {
            throw new IllegalArgumentException("Component cannot be null");
        }
        components.put(name, component);
        logger.info("Registered component: " + name);
    }

    /**
     * Starts the self-healing system.
     */
    public void start() {
        if (isRunning) {
            logger.warning("Self-healing system is already running");
            return;
        }
        isRunning = true;
        logger.info("Starting self-healing system...");
        for (String name : components.keySet()) {
            startComponent(name);
        }
    }

    /**
     * Stops the self-healing system.
     */
    public void stop() {
        if (!isRunning) {
            logger.warning("Self-healing system is not running");
            return;
        }
        isRunning = false;
        logger.info("Stopping self-healing system...");
        for (String name : components.keySet()) {
            stopComponent(name);
        }
    }

    /**
     * Starts monitoring a specific component.
     * @param name The name of the component.
     */
    private void startComponent(String name) {
        Component component = components.get(name);
        if (component != null) {
            component.start();
            logger.info("Started monitoring component: " + name);
        } else {
            logger.warning("Component not found: " + name);
        }
    }

    /**
     * Stops monitoring a specific component.
     * @param name The name of the component.
     */
    private void stopComponent(String name) {
        Component component = components.get(name);
        if (component != null) {
            component.stop();
            logger.info("Stopped monitoring component: " + name);
        } else {
            logger.warning("Component not found: " + name);
        }
    }

    /**
     * Handles an error in a specific component.
     * @param name The name of the component.
     * @param error The error that occurred.
     */
    public void handleError(String name, Throwable error) {
        Component component = components.get(name);
        if (component != null) {
            logger.severe("Error in component: " + name + " - " + error.getMessage());
            try {
                recoveryStrategy.handleRecovery(name, component, error);
                logger.info("Recovery strategy applied for component: " + name);
            } catch (Exception e) {
                logger.severe("Failed to apply recovery strategy for component: " + name + " - " + e.getMessage());
                // Fallback: Attempt to restart the component
                restartComponent(name);
            }
        } else {
            logger.warning("Component not found for error handling: " + name);
        }
    }

    /**
     * Restarts a specific component.
     * @param name The name of the component.
     */
    private void restartComponent(String name) {
        Component component = components.get(name);
        if (component != null) {
            component.stop();
            component.start();
            logger.info("Restarted component: " + name);
        } else {
            logger.warning("Component not found for restart: " + name);
        }
    }

    /**
     * Gets the current status of the system.
     * @return A string describing the system status.
     */
    public String getStatus() {
        StringBuilder status = new StringBuilder();
        status.append("System Status: ").append(isRunning ? "Running" : "Stopped").append("\n");
        status.append("Registered Components: ").append(components.size()).append("\n");
        for (String name : components.keySet()) {
            Component component = components.get(name);
            status.append("  - ").append(name).append(": ").append(component.isRunning() ? "Running" : "Stopped").append("\n");
        }
        return status.toString();
    }

    /**
     * The main entry point for testing the self-healing system.
     * @param args Command line arguments (not used).
     */
    public static void main(String[] args) {
        SelfHealingSystem system = new SelfHealingSystem();

        // Register a sample component
        system.registerComponent("SampleComponent", new SampleComponent());

        // Start the system
        system.start();

        // Simulate an error
        try {
            Thread.sleep(1000); // Wait for the component to start
            ((SampleComponent) system.components.get("SampleComponent")).simulateError();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // Print the status
        System.out.println(system.getStatus());

        // Stop the system
        system.stop();
    }
}

/**
 * Interface for components that can be monitored and healed.
 */
interface Component {
    void start();
    void stop();
    boolean isRunning();
}

/**
 * Default recovery strategy for components.
 */
class DefaultRecoveryStrategy implements RecoveryStrategy {
    @Override
    public void handleRecovery(String componentName, Component component, Throwable error) {
        // Default strategy: Log the error and attempt to restart the component
        System.err.println("Default recovery: Restarting component " + componentName);
        component.stop();
        component.start();
    }
}

/**
 * Interface for recovery strategies.
 */
interface RecoveryStrategy {
    void handleRecovery(String componentName, Component component, Throwable error);
}

/**
 * Sample component for demonstration purposes.
 */
class SampleComponent implements Component {
    private volatile boolean running = false;
    private Thread monitorThread;
    private final Logger logger = Logger.getLogger(SampleComponent.class.getName());

    @Override
    public void start() {
        if (running) {
            return;
        }
        running = true;
        monitorThread = new Thread(() -> {
            while (running) {
                try {
                    logger.info("Monitoring sample component...");
                    // Simulate some work
                    Thread.sleep(5000);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
        });
        monitorThread.start();
        logger.info("Sample component started");
    }

    @Override
    public void stop() {
        running = false;
        if (monitorThread != null) {
            monitorThread.interrupt();
            try {
                monitorThread.join(1000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        logger.info("Sample component stopped");
    }

    @Override
    public boolean isRunning() {
        return running;
    }

    /**
     * Simulates an error for testing purposes.
     */
    public void simulateError() {
        // Simulate an error condition
        throw new RuntimeException("Simulated error in SampleComponent");
    }
}
