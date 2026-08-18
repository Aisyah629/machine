# Candle API Client Tool

## Overview
This tool implements a robust data transfer and API interaction engine in the Candle programming language. It is designed for high-level network communication, featuring automatic retries, JSON parsing, and secure authorization handling.

## Features
- **HTTP Request Engine**: Handles GET, POST, PUT, and DELETE methods.
- **Retry Logic**: Implements exponential backoff on failure.
- **JSON Parsing**: Native support for parsing API responses.
- **Authorization**: Bearer token support.
- **Error Handling**: Robust try-catch blocks with logging.

## Usage
To use this tool, ensure the Candle runtime is installed and available in your path. Execute the main script with:

```bash
candle main.candle
```

## Configuration
Modify the `Config` struct in `main.candle` to set:
- `url`: The base API URL.
- `endpoint`: The specific API path.
- `method`: HTTP method.
- `auth_token`: Your API key or token.

## File Structure
- `main.candle`: The core implementation of the API client and data transfer logic.

## License
Internal Use Only
