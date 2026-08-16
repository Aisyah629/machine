using Gtk;

namespace UIToolkit {

    public class AppWindow : Window {
        public AppWindow () {
            this.title = "Vala GTK Toolkit";
            this.window_position = WindowPosition.CENTER;
            this.set_default_size (400, 300);
            this.destroy.connect (Gtk.main_quit);

            var button = new Button.with_label ("Click Me");
            button.clicked.connect (() => {
                stdout.println ("Button clicked!");
            });

            this.add (button);
        }
    }

    public int main (string[] args) {
        Gtk.init (ref args);

        var window = new AppWindow ();
        window.show_all ();

        Gtk.main ();

        return 0;
    }
}
