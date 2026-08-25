# Genie Data Processing Tool

A lightweight data processing utility written in Genie, leveraging the Meson build system and GTK/GLib integration.

## Features
- Read and parse CSV/TXT data
- Perform basic transformations (filtering, mapping)
- Output processed data to standard output or files

## Requirements
- Vala compiler (vapis for Genie are included)
- Meson build system
- GLib, GObject

## Installation
1. Ensure `genie` and `meson` are installed.
2. Run `meson setup builddir`.
3. Run `ninja -C builddir`.

## Usage
```bash
./builddir/main <input_file.csv>
```

## License
MIT
