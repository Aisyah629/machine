# CLIST Tool

This is a dedicated folder for the CLIST tool. CLIST (CLl Interactive System Test) is a script programming language used in IBM mainframe operating systems, particularly OS/360 and later versions, for writing interactive session scripts. It is commonly used for automating system tasks, interacting with datasets, and controlling job steps.

## Usage

This tool allows you to write and execute CLIST scripts. It provides an environment for creating interactive sessions and automating tasks within the mainframe context.

## Structure

- `main.cl`: The main CLIST script file.

## Example

```clist
/* Main CLIST */
SET &VAR1 = 'Hello'
SET &VAR2 = 'World'

WRITE &VAR1
WRITE &VAR2

EXIT
```

This script sets two variables, &VAR1 and &VAR2, writes them to the output, and then exits.
