# MDL Structural Tool

## Overview
This tool implements a batch drawing annotation automation script using MDL (Macro Description Language). It provides functionality for automated dimensioning of lines and polylines, along with drawing metadata export capabilities.

## Features
- **Automated Dimensioning**: Scans selected LINE and LWPOLYLINE entities and applies linear dimensions.
- **Configuration Control**: Adjustable annotation scale and text height parameters.
- **Metadata Export**: Generates a text file containing current drawing context and configuration.
- **Error Handling**: Safely skips non-dimensionable entities and reports progress.

## Usage
1. Load the script into your AutoCAD MDL environment.
2. Select entities to annotate.
3. Run `BATCH-ANNOTATE` to apply dimensions.
4. Run `EXPORT-METADATA` to save drawing configuration details.

## Configuration
- `*annotation-scale*`: Global scale factor for dimensions.
- `*text-height*`: Height of dimension text.
- `*dim-style*`: Active dimension style name.

## Notes
- Requires AutoCAD MDL runtime environment.
- Ensure `DIMSTYLE` is properly configured before running annotation routines.
