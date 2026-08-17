# Harbour Tool

## Overview
The `harbour_tool` is a dedicated execution environment for building, testing, and deploying applications using the Harbour programming language (an xBase-compatible dialect). It is optimized for enterprise-grade database access, legacy system integration, and high-performance data processing.

## Objective
Develop a robust enterprise data management and reporting system featuring real-time transaction processing and seamless multi-database integration.

## Architecture & Capabilities
- **Database Connectivity:** Direct support for DBF, SQL, Oracle, MySQL, PostgreSQL, and SQLite via Harbour's built-in `DBFCDX` and ODBC bridges.
- **Business Logic Engine:** Compiled xBase syntax execution with Just-In-Time (JIT) compilation capabilities for maximum throughput.
- **Reporting Module:** Native HTML, PDF, and CSV export engines integrated with data filtering and aggregation pipelines.
- **Transaction Management:** ACID-compliant transaction handling with optimistic and pessimistic locking strategies.
- **CLI Interface:** Command-line execution wrapper for batch processing, data migration, and scheduled report generation.

## Usage Instructions
1. Place your `.prg` (Harbour source) files into the `harbour_tool` directory.
2. Compile using the standard Harbour compiler: `hbmk2 main.prg`
3. Execute the compiled binary directly within the workspace environment.
4. Configure connection strings and environment variables in `config.env` as needed.

## Constraints
- Must strictly use valid Harbour/xBase syntax.
- No external GUI frameworks permitted; focus on console/CLI and server-side logic.
- All database interactions must utilize parameterized queries to prevent injection vulnerabilities.

## Maintenance & Updates
- Regularly update Harbour compiler binaries to the latest stable release.
- Verify compatibility with target database drivers.
- Maintain strict version control for all `.prg` source files.
