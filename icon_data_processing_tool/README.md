# Icon Data Processing Tool

## Description
The Icon Data Processing Tool is a utility designed to process and manipulate data lines using the Icon programming language. It provides functionalities such as sorting, filtering, reversing, and counting lines of data.

## Features
- **Sort**: Sort lines alphabetically.
- **Filter**: Remove empty lines from the input.
- **Reverse**: Reverse the order of lines.
- **Count**: Count the total number of non-empty lines.

## Installation
1. Ensure you have the Icon programming language installed on your system.
2. Clone or download this repository.
3. Make the `main.icn` file executable if needed.

## Usage
### Command Line
Run the tool from the command line with optional arguments:

```bash
icon main.icn [input_file] [options]
```

### Options
- `--sort`: Sort the data alphabetically.
- `--filter`: Filter out empty lines.
- `--reverse`: Reverse the order of lines.
- `--count`: Count the total number of non-empty lines.

### Examples
1. **Sort Data**
   ```bash
   icon main.icn input.txt --sort
   ```

2. **Count Lines**
   ```bash
   icon main.icn input.txt --count
   ```

3. **Reverse Data**
   ```bash
   icon main.icn input.txt --reverse
   ```

4. **Filter Empty Lines**
   ```bash
   icon main.icn input.txt --filter
   ```

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the MIT License.

## Author
Developed as part of the data processing tool suite.
