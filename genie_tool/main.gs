using GLib
using Gtk
using Gee

/**
 * Genie GUI Framework
 * A cross-platform tool for building GNOME applications with
 * declarative layouts and robust signal-slot event handling.
 */

namespace GenieTool {

	class WidgetSignalManager : Object {
		public signal void on_widget_ready (Widget self)
		public signal void on_event_triggered (string event_name)
		public signal void on_data_updated (string key, Variant value)

		public construct () {
			base ()
		}

		public void trigger_ready (Widget w) {
			on_widget_ready(w)
		}

		public void trigger_event (string event) {
			on_event_triggered(event)
		}

		public void update_data (string key, Variant val) {
			on_data_updated(key, val)
		}
	}

	class DeclarativeLayout : Object {
		public Box box
		public Grid grid
		public Stack stack

		public construct (Orientation orient, int spacing, int margin) {
			base ()
			box = new Box (orient, spacing)
			grid = new Grid ()
			stack = new Stack ()
			grid.set_margin_all (margin)
			box.set_margin_all (margin)
		}

		public void add_to_grid (Widget child, int left, int top, int width, int height) {
			grid.attach (child, left, top, width, height)
		}

		public void add_to_box (Widget child) {
			box.pack_start (child, true, true, 0)
		}
	}

	class AppContext : Object {
		public string app_name
		public string app_version
		public WidgetSignalManager signals
		public declarative_layout: DeclarativeLayout

		public construct (string name, string version) {
			base ()
			app_name = name
			app_version = version
			signals = new WidgetSignalManager ()
			declarative_layout = new DeclarativeLayout (Orientation.VERTICAL, 12, 24)
		}

		public void init () {
			Stdout.printf ("[GenieTool] Initializing %s v%s...\n", app_name, app_version)
		}

		public void run () {
			Stdout.printf ("[GenieTool] Running %s...\n", app_name)
			// Main loop placeholder
		}
	}

	static int main (string[] args) {
		Gtk.init ()

		var ctx = new AppContext ("GenieTool", "1.0.0")
		ctx.init ()

		var window = new Window ()
		window.set_title (ctx.app_name)
		window.set_default_size (800, 600)

		var container = new Box (Orientation.VERTICAL, 10)
		container.set_margin_all (15)
		window.add (container)

		var label = new Label ("Genie Cross-Platform Framework")
		label.set_markup ("<b>Welcome to the Genie Tool</b>")
		container.pack_start (label, false, false, 0)

		var btn = new Button.with_label ("Trigger Event")
		btn.clicked.connect (() => {
			ctx.signals.trigger_event("button_click")
			Stdout.printf ("[GenieTool] Event 'button_click' triggered.\n")
		})
		container.pack_start (btn, false, false, 0)

		// Signal connections
		ctx.signals.on_widget_ready.connect ((w) => {
			Stdout.printf ("[GenieTool] Widget ready: %s\n", w.get_name ())
		})

		ctx.signals.trigger_ready (window)

		window.show_all ()
		ctx.run ()

		return 0
	}
}
