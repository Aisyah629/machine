public class main {

    public static void main(String[] args) {
        System.out.println("Starting AspectJ Crosscutting Engine Tool...");

        // Example usage of monitored methods
        performTask1();
        performTask2();
        performTask3();

        System.out.println("All tasks completed.");
    }

    @Monitor
    public static void performTask1() {
        System.out.println("Performing Task 1...");
        try {
            Thread.sleep(500);
        } catch (InterruptedException e) {
            throw new RuntimeException("Task 1 interrupted", e);
        }
        System.out.println("Task 1 completed successfully.");
    }

    @Monitor
    public static void performTask2() {
        System.out.println("Performing Task 2...");
        try {
            Thread.sleep(300);
        } catch (InterruptedException e) {
            throw new RuntimeException("Task 2 interrupted", e);
        }
        System.out.println("Task 2 completed successfully.");
    }

    @Monitor
    public static void performTask3() {
        System.out.println("Performing Task 3...");
        try {
            Thread.sleep(100);
        } catch (InterruptedException e) {
            throw new RuntimeException("Task 3 interrupted", e);
        }
        System.out.println("Task 3 completed successfully.");
    }
}
