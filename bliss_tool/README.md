# Bliss Tool - API Client

This tool is written in BLISS and provides a robust data transfer and API interaction script.

## Features

- TCP Socket Communication
- HTTP Request Building
- Data Transfer and Response Handling
- Host Extraction from URL

## Usage

To compile and run this tool, you will need a BLISS compiler. Here is an example of how you might compile and use it:

1. **Compile:**
   ```bash
   bliss -o api_client main.bliss
   ```

2. **Run:**
   ```bash
   ./api_client
   ```

## Components

- **send_request**: Sends an HTTP request to a specified host and port.
- **receive_response**: Receives a response from a connected socket.
- **transfer_data**: Manages the entire process of transferring data via an API.
- **build_request**: Constructs an HTTP request string.
- **extract_host**: Extracts the host from a URL string.

## License

This project is licensed under the MIT License.
