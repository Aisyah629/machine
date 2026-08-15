using GLib;
using Gtk;

namespace ValaTool {
    /// <summary>
    /// Main application class for the Vala Tool.
    /// Demonstrates object-oriented programming with GLib and GTK integration.
    /// </summary>
    public class ValaApp : Application {
        public ValaApp () {
            Object (application_id: "com.valatool.app");
        }

        public override void activate () {
            Window window = new Window (WindowType.TOPLEVEL);
            window.title = "Vala Tool";
            window.border_width = 10;
            window.set_default_size (400, 300);

            Button button = new Button.with_label ("Click Me!");
            button.clicked.connect (() => {
                print ("Button clicked!\n");
            });

            window.add (button);
            window.show_all ();
        }

        public static int main (string[] args) {
            ValaApp app = new ValaApp ();
            return app.run (args);
        }
    }

    /// <summary>
    /// Example class demonstrating custom GObject subclassing.
    /// </summary>
    public class CustomGObject : Object {
        public string name { get; set; }
        public int value { get; set; }

        public CustomGObject (string name, int value) {
            this.name = name;
            this.value = value;
        }

        public void display () {
            print ("CustomGObject Name: %s, Value: %d\n", this.name, this.value);
        }
    }

    /// <summary>
    /// Example class demonstrating inheritance and interfaces.
    /// </summary>
    public interface ITask {
        abstract void execute ();
    }

    public class Task : Object, ITask {
        public string task_name { get; set; }
        public bool is_completed { get; set; }

        public Task (string task_name) {
            this.task_name = task_name;
            this.is_completed = false;
        }

        public void execute () {
            print ("Executing task: %s\n", this.task_name);
            this.is_completed = true;
            print ("Task '%s' completed.\n", this.task_name);
        }
    }

    /// <summary>
    /// Utility class for basic operations.
    /// </summary>
    public class Calculator {
        public static double add (double a, double b) {
            return a + b;
        }

        public static double subtract (double a, double b) {
            return a - b;
        }

        public static double multiply (double a, double b) {
            return a * b;
        }

        public static double divide (double a, double b) {
            if (b == 0) {
                throw new ArithmeticError.DIVISION_BY_ZERO;
            }
            return a / b;
        }
    }

    /// <summary>
    /// Entry point for non-GUI demonstrations.
    /// </summary>
    public class CLIApp {
        public static int main (string[] args) {
            print ("=== Vala Tool CLI Demo ===\n");

            // Demonstrate CustomGObject
            CustomGObject obj = new CustomGObject ("ExampleObject", 42);
            obj.display ();

            // Demonstrate Interfaces
            ITask task1 = new Task ("Write Documentation");
            task1.execute ();

            // Demonstrate Calculator
            double result = Calculator.add (10, 20);
            print ("10 + 20 = %.2f\n", result);

            result = Calculator.subtract (50, 25);
            print ("50 - 25 = %.2f\n", result);

            result = Calculator.multiply (5, 6);
            print ("5 * 6 = %.2f\n", result);

            try {
                result = Calculator.divide (100, 10);
                print ("100 / 10 = %.2f\n", result);
            } catch (ArithmeticError e) {
                print ("Error: %s\n", e.message);
            }

            return 0;
        }
    }
}
