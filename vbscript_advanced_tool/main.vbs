' VBScript Advanced Tool
' File System Organization and Batch Processing Utility

Option Explicit

' Configuration Constants
Const LOG_FILE = "operation_log.txt"
Const SOURCE_DIR = "." ' Current directory as default
Const DEST_DIR = "organized_files"
Const MAX_LOG_ENTRIES = 1000

' Main Procedure
Sub Main()
    Dim fso, logStream, entryCount
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set logStream = CreateLogFile(fso, LOG_FILE)
    
    If Not ValidateDirectory(fso, SOURCE_DIR, logStream) Then
        Exit Sub
    End If
    
    entryCount = 0
    ProcessFiles fso, SOURCE_DIR, DEST_DIR, logStream, entryCount
    
    logStream.WriteLine "Processing complete. Processed " & entryCount & " files."
    logStream.Close
    MsgBox "Processing complete. See " & LOG_FILE & " for details.", vbInformation
End Sub

' Validate Source Directory
Function ValidateDirectory(fso, path, logStream)
    If Not fso.FolderExists(path) Then
        logStream.WriteLine "Error: Source directory '" & path & "' does not exist."
        ValidateDirectory = False
        Exit Function
    End If
    ValidateDirectory = True
    logStream.WriteLine "Source directory validated: " & path
End Function

' Create Log File
Function CreateLogFile(fso, logPath)
    Dim logStream
    If fso.FileExists(logPath) Then
        Set logStream = fso.OpenTextFile(logPath, 8, False) ' 8 = ForAppending
    Else
        Set logStream = fso.CreateTextFile(logPath, True)
    End If
    Set CreateLogFile = logStream
End Function

' Process Files
Sub ProcessFiles(fso, sourceDir, destDir, logStream, entryCount)
    Dim folder, files, file, ext, destPath
    Set folder = fso.GetFolder(sourceDir)
    Set files = folder.Files
    
    ' Create destination directory if it doesn't exist
    If Not fso.FolderExists(destDir) Then
        fso.CreateFolder destDir
        logStream.WriteLine "Created destination directory: " & destDir
    End If
    
    For Each file In files
        ext = UCase(fso.GetExtensionName(file.Name))
        If ext <> "" Then
            destPath = fso.BuildPath(fso.BuildPath(destDir, ext), file.Name)
            If Not fso.FileExists(destPath) Then
                file.Move destPath
                logStream.WriteLine "Moved: " & file.Name & " to " & destPath
                entryCount = entryCount + 1
            Else
                logStream.WriteLine "Skipped (exists): " & file.Name
            End If
        Else
            logStream.WriteLine "Skipped (no extension): " & file.Name
        End If
    Next
End Sub

' Start Main
Main
