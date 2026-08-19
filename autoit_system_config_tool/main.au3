#Region ;****  AutoIt  Script - Main System Configuration Tool ****
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=1033

#include <MsgBoxConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <WinAPIReg.au3>

; Constants for system configuration paths
Const $REGISTRY_CONFIG_PATH = "HKLM\SOFTWARE\SystemConfig"
Const $LOG_FILE_PATH = @ScriptDir & "\config.log"

; Main function
Func _Main()
    ; Initialize logger
    _Log("System configuration tool started.")
    
    ; Display configuration options
    Local $configChoice = _DisplayMenu()
    
    ; Process user choice
    Switch $configChoice
        Case 1
            _ApplyBasicConfiguration()
        Case 2
            _UpdateRegistrySettings()
        Case 3
            _InstallDefaultSoftware()
        Case 4
            _SystemCleanup()
        Case Else
            _ExitTool()
    EndSwitch
    
    _Log("System configuration tool finished.")
EndFunc

; Display the configuration menu
Func _DisplayMenu()
    Local $menu = "Select Configuration Option:\n" & _
                  "1. Apply Basic System Settings\n" & _
                  "2. Update Registry Settings\n" & _
                  "3. Install Default Software\n" & _
                  "4. Perform System Cleanup\n" & _
                  "5. Exit\n"
    
    Local $choice = InputBox("System Configuration Tool", $menu, "", "", -1, -1, -1, -1)
    Return Number($choice)
EndFunc

; Apply basic system configuration settings
Func _ApplyBasicConfiguration()
    _Log("Applying basic system configuration settings...")
    
    ; Example: Set desktop wallpaper
    Local $wallpaperPath = @ScriptDir & "\wallpaper.bmp"
    If FileExists($wallpaperPath) Then
        _WinAPI_WritePrivateProfileString("Desktop", "WallPaper", $wallpaperPath, @ScriptDir & "\user.bmp")
        _WinAPI_SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $wallpaperPath, $SPIF_UPDATEINIFILE + $SPIF_SENDWININICHANGE)
        _Log("Wallpaper set to: " & $wallpaperPath)
    Else
        _Log("Wallpaper file not found: " & $wallpaperPath)
    EndIf
    
    ; Example: Set file associations
    _Log("File associations updated.")
EndFunc

; Update registry settings
Func _UpdateRegistrySettings()
    _Log("Updating registry settings...")
    
    ; Create a registry key if it doesn't exist
    If RegRead($REGISTRY_CONFIG_PATH, "") = @CRLF Then
        RegWrite($REGISTRY_CONFIG_PATH, "", "REG_SZ", "Configured")
        _Log("Registry key created: " & $REGISTRY_CONFIG_PATH)
    Else
        _Log("Registry key already exists: " & $REGISTRY_CONFIG_PATH)
    EndIf
    
    ; Example: Set a registry value
    RegWrite($REGISTRY_CONFIG_PATH, "Version", "REG_SZ", "1.0")
    _Log("Registry value 'Version' set to 1.0")
EndFunc

; Install default software
Func _InstallDefaultSoftware()
    _Log("Installing default software...")
    
    ; Example: Silent install of a program (Replace with actual installers)
    Local $installCommand = 'msiexec /i "C:\Path\To\Installer.msi" /qn'
    ShellExecuteWait(@ComSpec, "/c " & $installCommand)
    
    _Log("Default software installation completed.")
EndFunc

; Perform system cleanup
Func _SystemCleanup()
    _Log("Performing system cleanup...")
    
    ; Example: Delete temporary files
    FileDelete(@TempDir & "\*.tmp")
    _Log("Temporary files deleted.")
    
    ; Example: Clear Recycle Bin
    ShellExecuteWait(@ComSpec, "/c $Recycle.Bin\* /q")
    _Log("Recycle Bin cleared.")
EndFunc

; Exit the tool
Func _ExitTool()
    _Log("Exiting system configuration tool.")
    Exit
EndFunc

; Logging function
Func _Log($message)
    Local $timestamp = @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC
    FileWrite($LOG_FILE_PATH, "[" & $timestamp & "] " & $message & @CRLF)
    ConsoleWrite("[" & $timestamp & "] " & $message & @CRLF)
EndFunc

; Call main function
_Main()
#EndRegion
