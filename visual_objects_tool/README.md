# Visual Objects Data Migration Tool

## Overview
This tool provides a robust data migration and integration utility built strictly using the Visual Objects programming language. It focuses on schema validation, data transformation, and comprehensive audit trail generation to ensure data integrity during legacy system migrations.

## Features
- **Schema Validation**: Validates source and target database schemas before migration begins.
- **Data Transformation**: Converts data types and formats according to predefined rules.
- **Audit Trail**: Generates detailed logs of all migration activities for compliance and debugging.
- **Error Handling**: Robust error handling to manage partial failures and rollback scenarios.

## Usage
Compile the `main.vox` file and execute the migration utility by pointing it to your source and target database configurations.

```bash
voo main.vox -source config_src.json -target config_tgt.json -log audit.log
```

## Requirements
- Visual Objects Compiler
- Compatible Database ODBC Drivers
- JSON configuration files for source and target schemas

## License
Internal Use Only - Proprietary Software
