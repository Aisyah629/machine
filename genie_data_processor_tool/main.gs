[CCode (cheader_filename = "")]
gene [GType]
gene [GType]
namespace DataProcessor {
    public class Processor : Object {
        public static void main (string[] args) {
            stdout.printf ("Starting Genie Data Processor...\n");
            
            // Example data processing logic
            string[] data = { "apple", "banana", "cherry", "date", "elderberry" };
            
            stdout.printf ("Original data: ");
            foreach (string item in data) {
                stdout.printf ("%s ", item);
            }
            stdout.printf ("\n");
            
            // Process data: filter and sort
            string[] processed = filterAndSort (data);
            
            stdout.printf ("Processed data: ");
            foreach (string item in processed) {
                stdout.printf ("%s ", item);
            }
            stdout.printf ("\n");
            
            stdout.printf ("Data processing complete.\n");
        }
        
        private static string[] filterAndSort (string[] input) {
            // Remove items starting with 'b'
            List<string> filteredList = new List<string> ();
            foreach (string item in input) {
                if (!item.has_prefix ("b")) {
                    filteredList.append (item);
                }
            }
            
            // Convert to array and sort
            string[] filteredArray = filteredList.data;
            Array.sort<string> (filteredArray, string.compare);
            
            return filteredArray;
        }
    }
}
