# Metafont Tool

## Overview

The `metafont_tool` is a dedicated utility for generating vector graphics using Metafont, a typesetting language designed primarily for font design. It provides a robust framework for rendering complex mathematical typography, geometric shapes, and custom vector designs.

## Features

- **Vector Graphics Generation**: Create precise vector paths and curves.
- **Mathematical Typography**: Render intricate mathematical symbols and formulas.
- **Custom Font Design**: Define custom glyphs and typefaces.
- **Scripting Support**: Execute Metafont scripts programmatically.

## Usage

### Basic Example

```metafont

gfulpen pencircle scaled .7bp;
def newpath expr p =
  p := fullcircle scaled 20 shifted (0, 0);
  p
def enddef;

path p;
p := newpath;
draw p;

end
```

### Advanced Example

```metafont

input mfbasics

def draw_symbol(expr n) =
  save d, x, y, t, r, theta;
  d := n * 1/2;
  x := 0;
  y := 0;
  t := 0;
  r := 1;
  theta := 0;
  for i = 0 to 359:
    theta := i * 1deg;
    x := r * cos(theta);
    y := r * sin(theta);
    if i = 0:
      penraw := pencircle scaled .5bp;
      draw (x, y);
    else:
      penraw := pencircle scaled .5bp;
      draw (x, y) shifted (x, y);
    fi
  endfor;
  draw_symbol(n + 1);
enddef;

beginfig(1);
  draw_symbol(0);
endfig;

end
```

## Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd metafont_tool
   ```

2. Install dependencies (if any):
   ```bash
   # No external dependencies required for basic usage
   ```

3. Run the tool:
   ```bash
   ./main.mf
   ```

## Contributing

Contributions are welcome! Please submit a pull request with your enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](../LICENSE) file for details.
