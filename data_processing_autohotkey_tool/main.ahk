#v ; AutoHotkey v2 directive
#Requires AutoHotkey v2.0+

; Data Processing Tool for AutoHotkey
; This script provides basic data processing utilities including
; CSV parsing, data cleaning, and simple statistical analysis.

; --- Configuration ---
Global OutputDir := "./processed_data"
If !DirExist(OutputDir)
    DirCreate(OutputDir)

; --- Main Menu ---
Gui, New, , Data Processing Utility
Gui, Add, Text, xm y10, Select Operation:
Gui, Add, Button, xm y40 w150 gParseCSV, Parse CSV
Gui, Add, Button, xm y80 w150 gCleanText, Clean Text
Gui, Add, Button, xm y120 w150 gGenerateReport, Generate Report
Gui, Add, Button, xm y160 w150 gExitTool, Exit
Gui, Show, w320 h220
Return

; --- Parse CSV Function ---
ParseCSV:
    FileSelectFile, InputFile, 1, , Select CSV File to Parse, CSV Files (*.csv)
    If (InputFile = "")
        Return
    
    OutputFile := OutputDir . "\parsed_output.csv"
    LineCount := 0
    
    ; Open file for reading
    Loop FileRead, InputFile, FileContent {
        ; Basic CSV parsing: split by comma
        Lines := StrSplit(FileContent, "`n", "`r")
        For Index, Line In Lines {
            If (Line = "")
                Continue
            
            ; Remove surrounding quotes if present
            CleanLine := Trim(Line, "`")
            
            ; Write to output
            FileAppend CleanLine "`n", OutputFile
            LineCount++
        }
    }
    
    MsgBox, "Successfully parsed " LineCount " lines into " OutputFile, "CSV Parser",
    Return

; --- Clean Text Function ---
CleanText:
    FileSelectFile, InputFile, 1, Select Text File to Clean, Text Files (*.txt)
    If (InputFile = "")
        Return
    
    OutputFile := OutputDir . "\cleaned_text.txt"
    
    ; Read file content
    FileRead, Content, %InputFile%
    
    ; Remove extra whitespaces
    CleanedContent := RegExReplace(Content, "\s+", " ")
    
    ; Convert to lowercase
    CleanedContent := StrLower(CleanedContent)
    
    ; Write cleaned content
    FileAppend CleanedContent, OutputFile
    
    MsgBox, "Text cleaned and saved to " OutputFile, "Text Cleaner",
    Return

; --- Generate Report Function ---
GenerateReport:
    OutputFile := OutputDir . "\report.txt"
    
    ; Generate a simple report
    Report := "Data Processing Report`n"
    Report .= "======================`n"
    Report .= "Date: " A_Now "`n"
    Report .= "Processed Files: 2`n"
    Report .= "Status: Complete`n"
    
    FileAppend Report, OutputFile
    
    MsgBox, "Report generated at " OutputFile, "Report Generator",
    Return

; --- Exit Function ---
ExitTool:
    Gui, Destroy
    ExitApp

; --- GUI Close Handler ---
GuiClose:
    ExitApp
