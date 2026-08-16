import java.text.SimpleDateFormat;
import java.util.Date;

public class Logger {

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public static void log(String message) {
        String timestamp = dateFormat.format(new Date());
        System.out.println("[" + timestamp + "] " + message);
    }

    public static void logError(String message) {
        String timestamp = dateFormat.format(new Date());
        System.out.println("[" + timestamp + "] ERROR: " + message);
    }

    public static void logInfo(String message) {
        String timestamp = dateFormat.format(new Date());
        System.out.println("[" + timestamp + "] INFO: " + message);
    }
}
