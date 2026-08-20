; ==================================================================================================
; AutoHotkey v2 Self-Healing Tool
; Focus: Handle edge cases, transient errors, and implement recovery mechanisms.
; ==================================================================================================

#Requires AutoHotkey v2.0
#SingleInstance Force
#NoTrayIcon

; Configuration
Config := {
  "logFile": A_AppData . "\SelfHealingTool\errors.log",
  "stateFile": A_AppData . "\SelfHealingTool\state.dat",
  "maxRetries": 3,
  "retryDelay": 1000 ; milliseconds
}

; Ensure directories exist
FileCreateDir(A_AppData . "\SelfHealingTool")

; Global State
State := {
  "operationsCompleted": 0,
  "errorsEncountered": 0,
  "lastSuccess": ""
}

; Load previous state if exists
LoadState()

; Setup Tray Menu
TraySetIcon() ; Hide tray icon as requested by #NoTrayIcon, but for debugging we might want to show it if needed. 
; For now, we run silently.

; Main Loop
MainLoop()

; ==================================================================================================
; Functions
; ==================================================================================================

MainLoop() {
  ; Simulate a series of tasks that might fail
  Tasks := [
    Task_1, Task_2, Task_3
  ]

  For idx, Task In Tasks {
    Try {
      Result := ExecuteWithHealing(Task, Config.maxRetries, Config.retryDelay)
      If Result {
        State.operationsCompleted++
        State.lastSuccess := A_Now
        SaveState()
        LogMessage("INFO", "Task " idx " completed successfully.")
      } Else {
        LogMessage("WARN", "Task " idx " returned false, but no exception thrown.")
      }
    } Catch e {
      State.errorsEncountered++
      LogMessage("ERROR", "Task " idx " failed fatally: " e.Message)
      ; In a real system, we might alert the user or shut down gracefully
      ExitApp(1)
    }
  }
  
  LogMessage("INFO", "All tasks completed. Summary: " State.operationsCompleted " succeeded, " State.errorsEncountered " errors.")
  ExitApp(0)
}

ExecuteWithHealing(TaskFunc, maxRetries, retryDelay) {
  For attempt := 1 To maxRetries {
    Try {
      Return TaskFunc()
    } Catch e {
      LogMessage("ERROR", "Attempt " attempt " failed: " e.Message)
      If attempt < maxRetries {
        LogMessage("INFO", "Retrying in " retryDelay "ms...")
        Sleep(retryDelay)
        ; Attempt recovery strategy if applicable
        AttemptRecovery(e)
      } Else {
        ; Final retry failed
        Return False
      }
    }
  }
  Return False
}

AttemptRecovery(ErrorObj) {
  ; Example recovery logic based on error type
  If ErrorObj.Message ~= /network/i {
    LogMessage("INFO", "Recovering from network error by resetting connection state.")
    ; ResetConnection()
  } Else If ErrorObj.Message ~= /file/i {
    LogMessage("INFO", "Recovering from file error by checking permissions.")
    ; CheckPermissions()
  } Else {
    LogMessage("WARN", "Unknown error type, no specific recovery applied.")
  }
}

; ==================================================================================================
; Simulated Tasks
; ==================================================================================================

Task_1() {
  ; Simulate a task that fails once then succeeds
  Static FailOnce := True
  If FailOnce {
    FailOnce := False
    Throw Exception("Transient Error: Simulated network timeout.")
  }
  Return True
}

Task_2() {
  ; Simulate a task that fails due to invalid input
  Input := ""
  If Input = "" {
    Throw Exception("Input validation error: Empty string provided.")
  }
  Return True
}

Task_3() {
  ; Simulate a task that succeeds immediately
  Return True
}

; ==================================================================================================
; Logging & State Management
; ==================================================================================================

LogMessage(Level, Message) {
  Timestamp := FormatDateTime("yyyy-MM-dd HH:mm:ss")
  LogLine := Format("[{Level}] [{Timestamp}] {Message}", Level: Level, Timestamp: Timestamp, Message: Message)
  Try {
    FileAppend(LogLine . "`n", Config.logFile)
  } Catch e {
    ; If logging fails, we are in trouble. Print to stderr if possible
    StdErr := GetStdHandle(2)
    if StdErr {
      ; Not directly possible in standard AHK v2 without DLL calls, so we ignore.
    }
  }
}

LoadState() {
  If FileExist(Config.stateFile) {
    Try {
      FileRead(State, Config.stateFile)
      ; Parse the object from string
      State := Eval(State)
    } Catch e {
      LogMessage("WARN", "Failed to load state, starting fresh.")
    }
  }
}

SaveState() {
  Try {
    FileAppend(ObjToJSON(State), Config.stateFile)
  } Catch e {
    LogMessage("ERROR", "Failed to save state: " e.Message)
  }
}

; Helper to convert Object to JSON string manually for compatibility if needed
; Using built-in JSON functionality in AHK v2
ObjToJSON(obj) {
  Return JSON.stringify(obj)
}

; Helper to parse JSON string to Object
JSONtoObj(str) {
  Return JSON.parse(str)
}

; Helper to get current date time
FormatDateTime(fmt) {
  Return FormatTime(A_Now, fmt)
}

; ==================================================================================================
; End of Script
; ==================================================================================================
