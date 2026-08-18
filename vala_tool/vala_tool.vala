using GLib;
using Gtk;

public class AutomationController : Object {
    private Application application;
    private ApplicationWindow main_window;
    private VBox main_layout;
    private Button start_btn;
    private Button stop_btn;
    private Label status_label;
    private Cancellable cancellable;
    private bool is_running = false;

    public AutomationController () {
        cancellable = new Cancellable ();
        this.application = new Application ("com.vala.automation", ApplicationFlags.FLAGS_NONE);
        this.application.activate.connect (() => {
            this.main_window = new ApplicationWindow (this.application);
            this.main_window.title = "Vala Desktop Automation Framework";
            this.main_window.set_default_size (600, 400);
            this.main_window.destroy.connect (() => {
                this.is_running = false;
                this.application.quit ();
            });

            this.main_layout = new VBox (false, 12);
            this.main_layout.set_margin_top (12);
            this.main_layout.set_margin_bottom (12);
            this.main_layout.set_margin_start (12);
            this.main_layout.set_margin_end (12);

            this.status_label = new Label ("Status: Idle");
            this.status_label.set_halign (Align.START);

            var button_box = new Box (Orientation.HORIZONTAL, 6);
            this.start_btn = new Button.with_label ("Start Automation");
            this.stop_btn = new Button.with_label ("Stop Automation");
            this.stop_btn.sensitive = false;

            this.start_btn.clicked.connect (() => on_start_clicked ());
            this.stop_btn.clicked.connect (() => on_stop_clicked ());

            button_box.pack_start (this.start_btn, false, false, 0);
            button_box.pack_start (this.stop_btn, false, false, 0);

            this.main_layout.pack_start (this.status_label, false, false, 0);
            this.main_layout.pack_end (button_box, false, false, 0);

            this.main_window.set_child (this.main_layout);
            this.main_window.present ();
        });

        this.application.run (Environment.get_application_args ());
    }

    private void on_start_clicked () {
        if (is_running) return;
        is_running = true;
        cancellable.reset ();
        this.start_btn.sensitive = false;
        this.stop_btn.sensitive = true;
        this.status_label.set_text ("Status: Running...");

        spawn_background_task ();
    }

    private void on_stop_clicked () {
        is_running = false;
        cancellable.cancel ();
        this.start_btn.sensitive = true;
        this.stop_btn.sensitive = false;
        this.status_label.set_text ("Status: Stopped");
    }

    private void spawn_background_task () {
        Thread.interrupt (); // Ensure threads are interruptible
        var task_thread = new Thread<void*>.create("automation_task", () => {
            try {
                for (int i = 0; i < 10 && is_running; i++) {
                    yield simulate_gui_update (i);
                }
            } catch (Error e) {
                stdout.println ("Task interrupted or failed: " + e.message);
            }
            return null;
        });
    }

    private async void simulate_gui_update (int step) {
        // Simulate asynchronous work using GLib.Timeout or a mock sleep
        yield timeout (200, SourcePRIORITY_DEFAULT);
        // In a real implementation, this would interact with X11/Wayland/Win32 APIs
        var new_status = "Processing Step %d/10".printf (step + 1);
        this.status_label.set_text ("Status: " + new_status);
        yield timeout (200, SourcePRIORITY_DEFAULT);
    }

    public static int main (string[] args) {
        Gtk.init ();
        var app = new AutomationController ();
        return 0;
    }
}
