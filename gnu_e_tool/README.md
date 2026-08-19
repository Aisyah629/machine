# GNU E Data Transfer & API Interaction Tool

This tool provides a robust framework for data transfer and API interactions within the GNU E environment. It supports both local file transfers and HTTP/HTTPS API interactions.

## Features

- **Local File Transfer**: Copy files between local paths with progress logging
- **HTTP API Interaction**: Send GET, POST, and other HTTP requests with JSON payloads
- **Authentication**: Support for Bearer token authentication
- **Error Handling**: Comprehensive error handling and logging
- **Configuration**: Easy configuration via command-line arguments

## Usage

### Local File Transfer
```bash
./gnu_e_tool <source_file> <destination_file>
```

Example:
```bash
./gnu_e_tool data.txt /backup/data.txt
```

### API Interaction
```bash
./gnu_e_tool <api_url> [method] [payload]
```

Example (GET request):
```bash
./gnu_e_tool https://api.example.com/data GET
```

Example (POST request with JSON payload):
```bash
./gnu_e_tool https://api.example.com/upload POST '{"file":"data.txt"}'
```

## Configuration

The tool automatically parses URLs to extract:
- Host and port
- Request path
- Authentication tokens (if present in URL as `token=` parameter)

## Error Handling

The tool provides detailed error messages for:
- Network connection failures
- Invalid URLs
- File I/O errors
- HTTP response parsing issues

## Dependencies

This tool requires:
- GNU E compiler environment
- Standard C libraries (libc, libm)
- Network support (libnet)
