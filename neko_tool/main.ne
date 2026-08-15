/**
 * Neko Tool - Main Module
 * 
 * This script demonstrates the basic functionality of the Neko language.
 */

/**
 * Print a greeting message
 */
function main() {
    sys.print("Hello from Neko Tool!\n");
    sys.print("This tool is built strictly with the Neko programming language.\n");
    return 0;
}

// Export the main function
$global("main", main);
