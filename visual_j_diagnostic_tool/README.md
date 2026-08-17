# Visual J# Diagnostic Tool

## Overview
A robust diagnostic utility built strictly in Visual J# designed to analyze legacy Windows Forms applications. It focuses on detecting deprecated API usage and generating automated refactoring suggestions to ensure modernization compliance.

## Features
- Legacy Code Analysis: Scans source files for deprecated or obsolete API calls specific to older .NET or Windows Forms frameworks.
- Deprecated API Detection: Identifies specific methods and classes that are marked for removal or have better modern equivalents.
- Automated Refactoring Suggestions: Outputs a detailed report with actionable steps to migrate from legacy patterns to modern C# or .NET equivalents.
- Compliance Checking: Verifies that the application adheres to current best practices and enterprise modernization standards.

## Usage
1. Place the `main.vjs` file in the root of your Visual J# project or compile it as a standalone diagnostic scanner.
2. Run the tool pointing to the target legacy application directory.
3. Review the generated diagnostic report for deprecated usage and refactoring paths.

## Building
Requires the Visual J# .NET Redistributable Package and the original Visual J# compiler to build the `main.vjs` source.

## Dependencies
- Visual J# .NET Runtime
- Legacy Windows Forms Assembly References (for signature matching)
