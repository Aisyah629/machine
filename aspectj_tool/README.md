# AspectJ Tool

This repository contains a comprehensive cross-cutting concern management framework built with AspectJ.

## Overview
The framework leverages AspectJ compile-time weaving to provide modular, reusable, and type-safe implementations of common cross-cutting concerns such as logging, transaction management, security, and performance monitoring.

## Features
- **Compile-time Weaving**: Enhances performance and eliminates runtime weaving overhead.
- **Modular Concerns**: Each concern is encapsulated in a dedicated aspect for easier maintenance and testing.
- **Type-safe Pointcuts**: Utilizes AspectJ's powerful pointcut language for precise join point selection.
- **Configuration-driven**: Allows dynamic enable/disable of concerns via system properties or configuration files.

## Usage
1. Compile your Java code with the AspectJ compiler (`ajc`).
2. Include the woven JARs in your classpath.
3. Configure concerns via the provided configuration manager.

## Architecture
- `LoggingAspect.aj`: Handles method entry/exit logging and error tracking.
- `TransactionAspect.aj`: Manages declarative transaction boundaries.
- `SecurityAspect.aj`: Enforces access control and authentication checks.
- `PerformanceMonitorAspect.aj`: Tracks execution times and provides metrics.

## Build
Use Maven with the `aspectj-maven-plugin` to compile and weave aspects automatically.

```xml
<plugin>
  <groupId>org.codehaus.mojo</groupId>
  <artifactId>aspectj-maven-plugin</artifactId>
  <version>1.14</version>
  <configuration>
    <source>11</source>
    <target>11</target>
  </configuration>
</plugin>
```

## License
MIT License
