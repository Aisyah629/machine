# XPath Tool

## Overview
The XPath Tool is a dedicated utility for processing, extracting, and transforming XML data using XPath 1.0/2.0 compliant expressions. It provides a standardized interface for compiling XPath queries, evaluating them against XML documents, and handling node-sets, scalar values, and boolean logic.

## Features
- XPath Query Compilation and Validation
- XML Document Parsing and Tree Traversal
- Node-Set Evaluation and Filtering
- Scalar Value Extraction (Numbers, Strings, Booleans)
- Standardized Command-Line Interface for Batch and Interactive Use
- Error Handling for Malformed Expressions and Invalid Nodes

## Usage
The tool reads an XML document and an XPath expression, compiles the expression, and outputs the evaluated result to stdout in JSON or plain text format.

### CLI Syntax
`xpath_tool <xml_file> <xpath_expression>`

### Example
`xpath_tool data.xml "/root/item[@id='1']/text()`

## Limitations
- Strictly adheres to XPath specification semantics
- Does not include full XSLT or XQuery processing
- Focused purely on query evaluation and node traversal

## License
MIT License
