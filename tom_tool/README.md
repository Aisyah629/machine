# TOM Tool

## Description

This tool implements a high-performance template transformation system for dynamic web application generation. It uses the TOM programming language to define templates and transformation rules, enabling the generation of complex web applications from a simple declarative specification.

## Usage

### Example TOM Template

```tom
template WebPage {
    header {
        title "Welcome to My Web App"
        nav {
            link href="/about" "About"
            link href="/contact" "Contact"
        }
    }
    body {
        section id="main" {
            h1 "Main Content"
            p "This is the main content of the page."
        }
    }
    footer {
        p "Copyright 2023 My Web App"
    }
}

transform WebPage to HTML {
    output file="index.html"
}
```

### Running the Tool

1. Save the above TOM template to a file named `webpage.tom`.
2. Run the TOM tool:

```sh
./tom_tool main.tom
```

This will generate an `index.html` file with the transformed content.

## Features

- **Declarative Templates**: Define your web pages using a simple, readable syntax.
- **Transformation Rules**: Customize how templates are converted to the target format.
- **Dynamic Content**: Easily integrate dynamic data into your templates.
- **High Performance**: Optimized for fast template processing, even for large applications.

## License

MIT
