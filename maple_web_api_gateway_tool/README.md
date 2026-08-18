# Maple Web API Gateway Tool

## Overview
This tool implements a lightweight, server-side web API gateway and data serialization parser strictly using the Maple programming language. It is designed to handle incoming HTTP requests, route them to appropriate handlers, and serialize/deserialize JSON data payloads in a Maple-compatible format.

## Features
- Core HTTP request listener and router
- Middleware support for logging, authentication, and request validation
- JSON serialization and deserialization engine
- Thread-safe connection pooling for concurrent requests
- Configurable port, host, and timeout settings

## Usage
To launch the API gateway server:
```
maple -q maple_web_api_gateway_tool/main.mpl
```

To test the built-in serialization module:
```
maple -q maple_web_api_gateway_tool/test_serialization.mpl
```

## Configuration
Edit `gateway_config.mpl` to set:
- `Port`: Server listening port (default: 8080)
- `Host`: Binding address (default: "localhost")
- `MaxConnections`: Concurrent connection limit (default: 100)
- `Timeout`: Request timeout in seconds (default: 30)

## Architecture
The implementation is divided into:
- `main.mpl`: Server initialization and request lifecycle management
- `router.mpl`: URL pattern matching and handler dispatching
- `serializer.mpl`: JSON parsing and Maple table conversion
- `middleware.mpl`: Cross-cutting concerns (logging, auth, validation)
- `test_serialization.mpl`: Unit tests for data transformation logic

## Limitations
- Pure Maple implementation (no external C libraries)
- Synchronous request handling model (suitable for low-to-medium throughput)
- Basic authentication only (no OAuth/JWT out of the box)

## License
MIT License
