' VBScript System Administration Tool
' Purpose: Comprehensive Windows system administration framework

Option Explicit

' Constants
Const ADS_SCOPE_SUBTREE = 2
Const ADS_UF_DONT_EXPIRE_PASSWD = &h10000
Const ADS_UF_ACCOUNTDISABLE = &h2

' Main execution
On Error Resume Next

Dim WshShell, Env, Args, LogFile
Set WshShell = CreateObject("WScript.Shell")
Set Args = WScript.Arguments

LogFile = "C:\\Windows\\System32\\vbscript_sysadmin.log"

If WScript.Arguments.Length = 0 Then
    LogMessage "No arguments provided. Usage: cscript main.vbs [action] [params]"
    LogMessage "Actions: adduser, deleteuser, resetpass, getstatus"
    WScript.Quit 1
End If

Dim Action
Action = LCase(Args(0))

Select Case Action
    Case "adduser"
        If WScript.Arguments.Length >= 3 Then
            CreateNewUser Args(1), Args(2), Args(3)
        Else
            LogMessage "Usage: cscript main.vbs adduser <username> <password> [fullname]"
        End If
    Case "deleteuser"
        If WScript.Arguments.Length >= 2 Then
            RemoveUser Args(1)
        Else
            LogMessage "Usage: cscript main.vbs deleteuser <username>"
        End If
    Case "resetpass"
        If WScript.Arguments.Length >= 3 Then
            ResetUserPassword Args(1), Args(2)
        Else
            LogMessage "Usage: cscript main.vbs resetpass <username> <newpassword>"
        End If
    Case "getstatus"
        GetSystemStatus
    Case Else
        LogMessage "Unknown action: " & Action
        WScript.Quit 1
End Select

If Err.Number <> 0 Then
    LogMessage "Error: " & Err.Description
    Err.Clear
    WScript.Quit 1
End If

LogMessage "Execution completed successfully."

' --- Helper Functions ---

Function CreateNewUser(Username, Password, Optional FullName)
    Dim OU, User, Domain
    Set OU = GetObject("WinNT://./Users")
    
    ' Check if user exists
    On Error Resume Next
    OU.Create "user", Username
    If Err.Number <> 0 Then
        If Err.Number = -2147023580 Then ' User exists
            LogMessage "User " & Username & " already exists."
            Err.Clear
            Exit Function
        Else
            Err.Raise Err.Number, Err.Source, Err.Description
        End If
    End If
    On Error GoTo 0
    
    Set User = GetObject("WinNT://./" & Username & ",user")
    User.FullName = IIf(FullName <> "", FullName, Username)
    User.SetPassword Password
    User.SetInfo
    
    ' Enable account (ensure flags are correct)
    Dim CurrentFlags
    CurrentFlags = User.UserFlags
    User.UserFlags = CurrentFlags And Not ADS_UF_ACCOUNTDISABLE
    User.SetInfo
    
    LogMessage "User " & Username & " created successfully."
End Function

Function RemoveUser(Username)
    Dim OU, User
    Set OU = GetObject("WinNT://./Users")
    
    On Error Resume Next
    OU.Delete "user", Username
    If Err.Number <> 0 Then
        LogMessage "Failed to delete user " & Username & ": " & Err.Description
        Exit Function
    End If
    On Error GoTo 0
    
    LogMessage "User " & Username & " deleted successfully."
End Function

Function ResetUserPassword(Username, NewPassword)
    Dim User
    Set User = GetObject("WinNT://./" & Username & ",user")
    
    On Error Resume Next
    User.SetPassword NewPassword
    If Err.Number <> 0 Then
        LogMessage "Failed to reset password for " & Username & ": " & Err.Description
        Exit Function
    End If
    On Error GoTo 0
    
    LogMessage "Password for user " & Username & " reset successfully."
End Function

Function GetSystemStatus
    Dim Computer, OS, CPU, MemTotal, MemFree
    Computer = "."
    
    ' Get OS Info
    Set OS = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & Computer & "\\root\\cimv2:Win32_OperatingSystem=@")
    LogMessage "OS: " & OS.Caption
    
    ' Get CPU Info
    Dim CPUSet, CPUItem
    Set CPUSet = GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & Computer & "\\root\\cimv2:Win32_Processor")
    For Each CPUItem In CPUSet
        LogMessage "CPU: " & CPUItem.Name
        Exit For ' Just show first CPU
    Next
    
    ' Get Memory Info
    MemTotal = OS.TotalVisibleMemorySize / 1024 ' Convert KB to MB
    MemFree = OS.FreePhysicalMemory / 1024
    LogMessage "Total Memory: " & MemTotal & " MB"
    LogMessage "Free Memory: " & MemFree & " MB"
End Function

Sub LogMessage(Message)
    Dim FSO, TS
    On Error Resume Next
    Set FSO = CreateObject("Scripting.FileSystemObject")
    Set TS = FSO.OpenTextFile(LogFile, 8, True) ' 8 = ForAppending
    TS.WriteLine "[" & Now & "] " & Message
    TS.Close
    WScript.Echo Message
End Sub

Function IIf(Expr, TruePart, FalsePart)
    If Expr Then
        IIf = TruePart
    Else
        IIf = FalsePart
    End If
End Function
