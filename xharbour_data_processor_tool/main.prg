/*
 * xHarbour Data Processor Tool
 * This script demonstrates data processing capabilities using xHarbour.
 * It includes functions for file I/O, data manipulation, and basic reporting.
 */

#include "xbrowse.ch"
#include "fileio.ch"
#include "string.ch"

/* Global configuration */
GLOBAL g_config := {}
GLOBAL g_data_buffer := {}

FUNCTION Main()
    /* Initialize the tool */
    Print( "Initializing xHarbour Data Processor Tool..." )
    InitializeGlobals()

    /* Read configuration */
    ReadConfig()

    /* Process data */
    ProcessDataFiles()

    /* Generate report */
    GenerateReport()

    Print( "Data processing complete." )
    RETURN

PROCEDURE InitializeGlobals()
    /* Define default configuration */
    g_config := {
        {"delimiter", ","},
        {"encoding", "UTF-8"},
        {"output_dir", "./output"}
    }
    RETURN

PROCEDURE ReadConfig()
    LOCAL c_file := "config.ini"
    LOCAL f_handle
    LOCAL c_line
    LOCAL n_field, c_value

    IF FileExists(c_file)
        f_handle := FOpen(c_file, FO_READ)
        IF f_handle >= 0
            WHILE !FEOF(f_handle)
                c_line := FGetLine(f_handle)
                IF !Empty(c_line)
                    n_field := At("=", c_line)
                    IF n_field > 0
                        c_field := Left(c_line, n_field - 1)
                        c_value := SubStr(c_line, n_field + 1)
                        SetConfigValue(c_field, Trim(c_value))
                    ENDIF
                ENDIF
            ENDDO
            FClose(f_handle)
        ENDIF
    ENDIF
    RETURN

PROCEDURE SetConfigValue(c_field, c_value)
    LOCAL n_idx, n_count
    n_count := Len(g_config)
    FOR n_idx := 1 TO n_count
        IF g_config[n_idx][1] == c_field
            g_config[n_idx][2] := c_value
            RETURN
        ENDIF
    NEXT
    AAdd(g_config, {c_field, c_value})
    RETURN

FUNCTION GetConfigValue(c_field, c_default)
    LOCAL n_idx, n_count
    n_count := Len(g_config)
    FOR n_idx := 1 TO n_count
        IF g_config[n_idx][1] == c_field
            RETURN g_config[n_idx][2]
        ENDIF
    NEXT
    RETURN IIf(Pres(c_default), c_default, "")

PROCEDURE ProcessDataFiles()
    LOCAL c_input_dir := "./input"
    LOCAL c_file
    LOCAL f_handle
    LOCAL c_line
    LOCAL n_fields, a_fields
    LOCAL n_total_records := 0

    IF DirectoryExists(c_input_dir)
        c_file := DirFirst(c_input_dir)
        WHILE !Empty(c_file)
            IF FileExists(PathName(c_input_dir, c_file))
                IF Upper(ExtName(c_file)) == "CSV"
                    f_handle := FOpen(PathName(c_input_dir, c_file), FO_READ)
                    IF f_handle >= 0
                        WHILE !FEOF(f_handle)
                            c_line := FGetLine(f_handle)
                            IF !Empty(c_line)
                                a_fields := StrParse(c_line, GetConfigValue("delimiter", ","))
                                AAdd(g_data_buffer, a_fields)
                                n_total_records++
                            ENDIF
                        ENDDO
                        FClose(f_handle)
                    ENDIF
                ENDIF
            ENDIF
            c_file := DirNext()
        ENDDO
        DirClose()
    ENDIF

    Print( "Processed " + Str(n_total_records) + " records." )
    RETURN

PROCEDURE GenerateReport()
    LOCAL c_output_file := PathName(GetConfigValue("output_dir", "./output"), "report.txt")
    LOCAL f_handle
    LOCAL n_records := Len(g_data_buffer)

    IF !DirectoryExists(GetConfigValue("output_dir", "./output"))
        DirectoryMake(GetConfigValue("output_dir", "./output"))
    ENDIF

    f_handle := FCreate(c_output_file)
    IF f_handle >= 0
        FWWrite(f_handle, "Data Processing Report\n")
        FWWrite(f_handle, "======================\n")
        FWWrite(f_handle, "Total Records Processed: " + Str(n_records) + "\n")
        FWWrite(f_handle, "\n")

        /* Display sample data */
        IF n_records > 0
            FWWrite(f_handle, "Sample Data:\n")
            FOR EACH a_record IN g_data_buffer[1..Min(n_records, 5)]
                FWWrite(f_handle, Join(a_record, " | ") + "\n")
            NEXT
        ELSE
            FWWrite(f_handle, "No data found.\n")
        ENDIF

        FClose(f_handle)
        Print( "Report generated: " + c_output_file )
    ELSE
        Print( "Error: Could not create report file." )
    ENDIF
    RETURN
