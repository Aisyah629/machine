# PeopleCode Business Logic Tool

## Overview
The PeopleCode Business Logic Tool is a robust engine designed for building, testing, and deploying custom business logic within PeopleSoft environments. It leverages the PeopleCode language to provide enterprise-grade automation, data manipulation, and process orchestration.

## Features
- **Strict PeopleCode Implementation**: 100% compliant with PeopleCode syntax and execution standards.
- **Business Rule Engine**: Evaluates and executes complex business rules dynamically.
- **Data Manipulation**: Advanced APIs for querying, updating, and validating PeopleSoft database objects.
- **Event-Driven Architecture**: Triggers actions based on component events and page activity.
- **Modular Design**: Easy integration into existing PeopleSoft applications via standard packages and classes.

## Getting Started
1. Clone the repository.
2. Ensure your environment supports the PeopleCode runtime.
3. Load the `main.pcode` script into your PeopleSoft application.
4. Configure business rules in the `config/rules` directory.
5. Execute the tool using the provided CLI wrapper or invoke via PeopleCode API.

## Usage
```peoplecode
import BUSINESS_LOGIC:*;

Local BUSINESS_LOGIC:Engine &engine = create BUSINESS_LOGIC:Engine();
&engine.LoadRules("config/rules/default.pr");
&engine.Execute("process_name", %AllOptions);
```
