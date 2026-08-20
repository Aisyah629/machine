# Cross-Platform Web API Client and Data Serialization Tool

This tool is a cross-platform web API client and data serialization tool, built strictly with **Haxe**.

## Features

* Cross-platform support (JavaScript, C++, C#, Java, Python, Flash).
* HTTP client for GET, POST, PUT, DELETE requests.
* JSON serialization and deserialization.
* Customizable headers, timeouts, and base URLs.
* Simple and flexible API.

## Usage

1. Clone the repository.
2. Install Haxe and the required libraries.
3. Compile the code for your desired target platform.
4. Run the compiled code.

## Example

```haxe
import haxe_cross_platform_api_tool.CrossPlatformApiClient;

var config = {
    baseUrl: "https://api.example.com",
    timeout: 5000,
    headers: {"Authorization": "Bearer token123"}
};
var client = new CrossPlatformApiClient(config);

var params = {page: "1", limit: "10"};
client.get("users", params).onSuccess(function(response) {
    trace("Response: " + response.data);
});
```
