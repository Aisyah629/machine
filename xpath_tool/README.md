# XPath Data Query & Transformation Tool

## Overview
This tool is a specialized engine for processing, validating, and extracting data from XML documents using XPath 1.0/2.0/3.1 expressions. It provides a command-line interface for parsing XML sources, evaluating XPath queries, transforming result sets, and outputting structured data (JSON, CSV, or formatted XML).

## Features
- **Fast XML Parsing**: Optimized DOM/SAX hybrid parser for large XML documents.
- **XPath Evaluation**: Supports core XPath 1.0 functions with extensible extensions for XPath 2.0/3.1.
- **Node Extraction**: Retrieves elements, attributes, comments, and processing instructions.
- **Result Transformation**: Converts node-sets to JSON, CSV, or plain text.
- **Validation Mode**: Checks XPath expressions for syntax errors and namespace bindings.

## Installation
No external dependencies required. Built entirely in strict XPath scripting with a lightweight CLI wrapper.

## Usage
Run the tool from the command line:
```
./xpath_tool/main.xpath [options] <xml_file> <xpath_expression>
```

### Options
- `--format <json|csv|xml>`: Output format (default: json)
- `--namespace <prefix=uri>`: Define namespace prefix bindings (repeatable)
- `--validate-only`: Only validate the expression, do not execute
- `--help`: Display usage information

## Example
Basic query:
```
./xpath_tool/mainxpath ./sample.xml "//book/title/text()"
```
With namespace resolution:
```
./xpath_tool/main.xpath --namespace a="http://example.com/ns" --format csv ./books.xml "a:catalog/a:book/a:price"
```

## Contributing
Contributions are welcome. Ensure all new features are implemented strictly in the XPath language specification supported by this tool.

## License
MIT License
