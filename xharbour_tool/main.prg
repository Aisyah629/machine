* xHarbour Main Module
* Demonstrates database connectivity, data manipulation, and cross-platform capabilities
* Strictly written in xHarbour

PROCEDURE Main()
    LOCAL cDBFFile := "data.dbf"
    LOCAL nRecCount := 0

    ? "=== xHarbour Tool Initialized ==="
    ? "Database: " + cDBFFile
    ? "Platform: " + PlatformName()
    ? "Version: " + HarbourVersion()
    
    InitializeDatabase(cDBFFile)
    nRecCount := SampleDataEntry(cDBFFile)
    DisplayRecords(cDBFFile)
    CleanUpDatabase(cDBFFile)
    
    ? "\n=== Processing Complete ==="
    RETURN

FUNCTION InitializeDatabase(cFile)
    LOCAL nRes
    nRes := DBCreate(cFile, "DBFCDX")
    IF nRes <> 0
        ERROR BLOCK {|| MsgInfo("Failed to create database: " + cFile)}
    ENDIF
    USE (cFile) ALIAS SampleDB NEW
    RETURN nRes

FUNCTION SampleDataEntry(cFile)
    LOCAL nCount := 0
    LOCAL aFields := {"ID", "Name", "Value"}
    LOCAL aTypes := {"N", "C", "N"}
    LOCAL aLens := {4, 30, 10}
    
    DBAppend()
    FieldPut(1, 1) && ID
    FieldPut(2, "Alpha Sample") && Name
    FieldPut(3, 150.75) && Value
    DBFlush()
    
    DBAppend()
    FieldPut(1, 2)
    FieldPut(2, "Beta Sample")
    FieldPut(3, 275.50)
    DBFlush()
    
    nCount := 2
    RETURN nCount

PROCEDURE DisplayRecords(cFile)
    USE (cFile) ALIAS SampleDB SHARED
    GO TOP
    ? "\n--- Records in Database ---"
    ? STR(RecNo(), 4) + ": " + TRIM(FieldGet(2)) + "; " + DTOC(FieldGet(3))
    WHILE ! EOF()
        SKIP
        ? STR(RecNo(), 4) + ": " + TRIM(FieldGet(2)) + "; " + DTOC(FieldGet(3))
    ENDDO
    ? "---------------------------"
    USE ALIAS SampleDB
    RETURN

PROCEDURE CleanUpDatabase(cFile)
    USE ALIAS SampleDB
    QUIT
    RETURN

FUNCTION PlatformName()
    RETURN IIF(OS() == "WINDOWS", "Windows", IIF(OS() == "LINUX", "Linux", "Cross-Platform"))

FUNCTION HarbourVersion()
    RETURN HB_VERSION

PROCEDURE ERROR_BLOCK()
    ERROR BLOCK {|| MsgError("Unhandled exception in xHarbour module")}
    RETURN
