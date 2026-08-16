# JCL Batch Orchestrator Tool

## Overview
A comprehensive Job Control Language (JCL) utility for orchestrating mainframe batch job execution. This tool provides robust job scheduling, conditional step routing, resource allocation protocols, and legacy dataset management capabilities.

## Features
- **Conditional Branch Routing:** Dynamically route job steps based on return codes and execution outcomes.
- **Resource Allocation Protocols:** Efficiently manage CPU, I/O, and storage resources across concurrent job streams.
- **Legacy Dataset Management:** Handle PDS, flat files, and VSAM datasets with optimized read/write operations.
- **Error Handling & Recovery:** Implement retry logic, automatic spooling, and detailed syslog integration.
- **System Resource Monitoring:** Track execution metrics, CPU time, and memory usage in real-time.

## Usage
To deploy this tool, submit the main job script `main.jcl` to the JES spool system. Ensure all referenced datasets and parameters are correctly configured in the execution environment.

## Architecture
The tool is built entirely in JCL, leveraging standard mainframe job control statements (`//JOB`, `//EXEC`, `//STEP`, `//JCLLIB`, `//SYSTSIN`, `//SYSIN`) to create a self-contained, legacy-compatible automation suite.

## Requirements
- Mainframe OS (z/OS, OS/390, or z/VSE)
- JES2 or JES3 spooling system
- Standard JCL utilities (IEFBR14, IDCAMS, IDCAMS, IEFBR14, SORT utilities)

## License
Proprietary - Internal Use Only
