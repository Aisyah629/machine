[
buildsystem: 3
requires: glib-2.0, gobject-2.0
description: Genie Data Processing Utility
version: 0.1.0
license: MIT
]

using GLib
using GObject

namespace DataProcessor {
	public class Config {
		public string input_path { get; set; }
		public string output_path { get; set; }
		public bool verbose { get; set; }
	}

	public class CSVParser {
		private string[] lines;
		private string delimiter;

		public CSVParser (string path, string delim = ",") {
			var content = File.get_contents (path);
			lines = content.split ("\n");
			delimiter = delim;
		}

		public string[] get_headers () {
			if (lines.length > 0) {
				return lines[0].split (delimiter);
			}
			return {};
		}

		public string[][] get_data_rows () {
			var rows = {};
			for (var i = 1; i < lines.length; i++) {
				if (string.len (lines[i]) > 0) {
					rows += lines[i].split (delimiter);
				}
			}
			return rows;
		}
	}

	public class DataProcessor {
		public DataProcessor () {
			stdout.printf ("Genie Data Processor initialized.\n");
		}

		public void process (string input) {
			try {
				var parser = new CSVParser (input);
				var headers = parser.get_headers ();
				var data = parser.get_data_rows ();

				stdout.printf ("Headers: %s\n", headers.join (", "));
				stdout.printf ("Rows processed: %d\n", data.length / headers.length);
				
				// Example simple transformation: uppercase first column
				for (int i = 0; i < data.length; i += headers.length) {
					data[i] = data[i].up ();
				}
				
				stdout.printf ("Transformation applied.\n");
			} catch (Error e) {
				stderr.printf ("Error: %s\n", e.message);
			}
		}
	}
}

public class Application : GLib.Object {
	
	[Command (name = "genie-data-processor", 
		       version = "0.1.0", 
		       synopsis = "Process data files", 
		       description = "A simple data processor written in Genie.")]
	private static int main (string[] args) {
		var context = new GLib.OptionContext ("- Data Processor");
		context.set_help_enabled (true);
		context.add_main_entries ({
			{"input", 'i', "Input file path"},
			{"output", 'o', "Output file path"},
			{"verbose", 'v', "Verbose output"}
		}, null, null);
		
		string? input = null;
		string? output = null;
		bool verbose = false;

		try {
			context.parse (ref args);
		} catch (GLib.Error e) {
			stderr.printf ("Option parsing failed: %s\n", e.message);
			return 1;
		}

		if (input == null) {
			stderr.printf ("Input file is required.\n");
			return 1;
		}

		var processor = new DataProcessor.DataProcessor ();
		processor.process (input);
		
		return 0;
	}
}
