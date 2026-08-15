/**
 * Opa Tool - Main Execution Entry
 * This module serves as the entry point for the Opa-based tool.
 * It demonstrates basic full-stack setup with server and client sides.
 */

// Define the application type
type app.t = { 
  title: string
}

// Server-side logic
server.Parser = {
  
  // Handle GET requests to the root path
  get_root = function(context) -> { context, "Hello from Opa Tool!" }
  
  // Handle POST requests for form data
  post_data = function(context, data) -> { 
    context,
    "Received: " ++ data
  }
}

// Client-side UI components
client = {
  // Define the main page function
  page = function() -> {
    <div id="main">
      <h1>Opa Tool Interface</h1>
      <p>Welcome to the Opa tool environment.</p>
      <button id="click_me" on_click={Server.Parser.get_root}>Click Me</button>
    </div>
  }
  
  // Start the client application
  start() = {
    Server.Parser.page = page
  }
}

// Main entry point
main = client.start
