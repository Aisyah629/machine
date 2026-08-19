# TOM Tool: Robust Data Transfer/API Interaction

This tool implements a robust data transfer and API interaction script using the **TOM** programming language.

## Features
- **API Interaction**: Sends HTTP requests with configurable methods, headers, and payloads.
- **Retry Logic**: Implements exponential backoff and retry mechanisms for reliability.
- **Logging**: Built-in logger for tracking operations, errors, and statuses.
- **Configuration**: Externalized configuration for endpoints, timeouts, and authentication.

## Files
- `main.tom`: The main script containing the core logic for API interaction and data transfer.

## Usage
1. Ensure you have a TOM interpreter installed.
2. Edit `main.tom` to configure the `api_config` section with your target URL and authentication token.
3. Run the script: `tom main.tom`

## Configuration
Modify the `[api_config]` section in `main.tom` to adjust:
- `base_url`: The target API endpoint.
- `method`: HTTP method (GET, POST, PUT, etc.).
- `content_type`: The content type of the request body.
- `timeout`: Request timeout in seconds.
- `retry_count`: Number of times to retry on failure.

## Authentication
Update the `Auth` class in `main.tom` with your API token.

## License
MIT License
