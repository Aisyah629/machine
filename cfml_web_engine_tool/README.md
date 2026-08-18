# CFML Web Engine Tool

## Overview
The CFML Web Engine Tool is a robust, high-performance server-side rendering engine built strictly in CFML (ColdFusion Markup Language). It provides a modular framework for dynamic tag processing, session management, and seamless database connectivity, designed for modern web application development and legacy system migration.

## Features
- **Dynamic Tag Parsing Engine**: Custom parser that handles both standard HTML/ColdFusion tags and custom application-specific markup with full syntax validation.
- **Session & State Management**: Secure, scalable session handling with configurable persistence backends (memory, database, or distributed cache).
- **Database Connectivity Module**: Abstraction layer supporting multiple RDBMS platforms (PostgreSQL, MySQL, SQL Server, Oracle) with connection pooling and transaction management.
- **Request/Response Lifecycle Hooks**: Pre- and post-processing hooks for logging, security filtering, and response transformation.
- **Configuration-Driven Routing**: Declarative routing engine with pattern matching, middleware injection, and fallback handling.

## Project Structure
```
cfml_web_engine_tool/
├── README.md
├── main.cfm
├── engine/Engine.cfc
├── engine/Parser.cfc
├── engine/Router.cfc
├── sessions/SessionManager.cfc
├── db/DBConnector.cfc
├── hooks/HookRegistry.cfc
└── config/settings.json
```

## Installation & Setup
1. Ensure a CFML-compatible runtime (Lucee or Adobe ColdFusion 2018+) is installed.
2. Place the `cfml_web_engine_tool` directory inside your CFML webroot.
3. Configure `config/settings.json` with your database credentials and engine preferences.
4. Deploy via your web server or run using the built-in development server.

## Usage Example
``cfml
// main.cfm
<cfset engine = new engine.Engine()>
<cfset engine.setConfig("config/settings.json")>
<cfset engine.init()>
<cfset engine.start()>
```

## License
Internal tool for autonomous polyglot software engineering. All rights reserved.
