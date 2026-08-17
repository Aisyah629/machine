# Cool Syntax Analyzer Tool

This repository contains a syntax analyzer and semantic analyzer built strictly using the Cool programming language. 

## Overview

The tool is designed to validate Cool source code, checking for syntax errors and performing basic semantic analysis. It is optimized for educational purposes, making it an ideal tool for classroom demonstrations and student projects.

## Features

- **Syntax Validation:** Ensures that the source code adheres to the Cool language specification.
- **Semantic Analysis:** Performs checks on variable declarations, method definitions, and type consistency.
- **Educational Focus:** Provides clear error messages that help students understand and fix issues in their code.

## Usage

To use the Cool Syntax Analyzer Tool, you must first compile the provided `main.cool` file into an executable using the `coolc` compiler:

1. Open your terminal and navigate to the `cool_syntax_analyzer_tool` directory.
2. Run the following command to compile the tool:

   ```bash
   coolc main.cool
   ```

3. After compilation, you can run the tool with the following command:

   ```bash
   ./main
   ```

4. Provide the path to the Cool source file you wish to analyze as a command-line argument:

   ```bash
   ./main path/to/your/file.cool
   ```

## Limitations

- The current implementation focuses on basic syntax and semantic analysis and does not support all advanced Cool features.
- Performance is optimized for educational use cases rather than large-scale code analysis.

## Contributing

Contributions are welcome! If you have ideas for improving the Cool Syntax Analyzer Tool or find bugs, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
