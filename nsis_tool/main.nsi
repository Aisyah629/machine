;
; NSIS Script: main.nsi
; This script creates a basic Windows installer using NSIS.
;

; Define the application name and version
Name "NSIS Tool Example"
OutFile "nsis_tool_installer.exe"
InstallDir "$PROGRAMFILES\NSISToolExample"

; Default section: install the application
Section "Install"
    SetOutPath "$INSTDIR"
    File /r "*"
    CreateShortCut "$DESKTOP\NSISToolExample.lnk" "$INSTDIR\main.nsi"
    WriteUninstaller "$INSTDIR\uninstall.exe"
    MessageBox MB_OK "Installation completed successfully!"
SectionEnd

; Uninstall section
Section "Uninstall"
    Delete "$INSTDIR\uninstall.exe"
    Delete "$DESKTOP\NSISToolExample.lnk"
    RMDir "$INSTDIR"
    RMDir "$DESKTOP"
    MessageBox MB_OK "Uninstallation completed successfully!"
SectionEnd
