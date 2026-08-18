        .ORIG x3000

; =============================================================================
; SELF-HEALING TOOL FOR LC-3
; =============================================================================
; This program implements a robust error-handling framework for LC-3.
; It handles edge cases, runtime errors, and system faults through
; structured exception handling, state recovery, and safe execution patterns.
; =============================================================================

; =============================================================================
; MEMORY LAYOUT
; =============================================================================
HEAP_START      .BLKW 1         ; Start of heap for dynamic allocation
CURRENT_STATE   .BLKW 1         ; Pointer to current execution state
ERROR_CODE      .BLKW 1         ; Current error code
RECOVERY_PTR    .BLKW 1         ; Pointer to recovery routine
STATE_HISTORY   .BLKW 10        ; History of states for rollback
SAVED_TRAP_R0   .BLKW 1         ; Saved R0 for trap operations
SAVED_TRAP_R1   .BLKW 1         ; Saved R1 for trap operations
SAVED_TRAP_R2   .BLKW 1         ; Saved R2 for trap operations
SAVED_TRAP_R3   .BLKW 1         ; Saved R3 for trap operations
SAVED_TRAP_R4   .BLKW 1         ; Saved R4 for trap operations
SAVED_TRAP_R5   .BLKW 1         ; Saved R5 for trap operations
SAVED_TRAP_R6   .BLKW 1         ; Saved R6 for trap operations
SAVED_TRAP_R7   .BLKW 1         ; Saved R7 for trap operations
SAVED_PC        .BLKW 1         ; Saved program counter
SAVED_COND      .BLKW 1         ; Saved condition flags

; =============================================================================
; ERROR CODES
; =============================================================================
ERR_NONE        .FILL x0000     ; No error
ERR_DIV_ZERO    .FILL x0001     ; Division by zero
ERR_MEM_VIOL    .FILL x0002     ; Memory violation
ERR_STACK_OVF   .FILL x0003     ; Stack overflow
ERR_INVALID_OP  .FILL x0004     ; Invalid operation
ERR_NULL_PTR    .FILL x0005     ; Null pointer access
ERR_TIMEOUT     .FILL x0006     ; Operation timeout
ERR_CORRUPT     .FILL x0007     ; Data corruption detected

; =============================================================================
; MAIN EXECUTION
; =============================================================================
        LEA R0, WELCOME_MSG
        TRAP x22          ; PUTS
        LEA R0, INIT_MSG
        TRAP x22          ; PUTS
        
        ; Initialize the self-healing system
        JSR R7, INIT_SYSTEM
        
        ; Enter the main error-handling loop
MAIN_LOOP
        JSR R7, HANDLE_NEXT_ERROR
        BRz EXECUTE_SAFE_OPERATION
        BRp EXECUTE_RECOVERY
        
        ; No error - proceed with normal operation
        JSR R7, RUN_NORMAL_OPERATION
        BR MAIN_LOOP
        
EXECUTE_RECOVERY
        JSR R7, ATTEMPT_RECOVERY
        BR MAIN_LOOP
        
EXECUTE_SAFE_OPERATION
        JSR R7, PERFORM_COMPUTATION
        BR MAIN_LOOP
        
; =============================================================================
; SYSTEM INITIALIZATION
; =============================================================================
INIT_SYSTEM
        ST R0, SAVED_R0_SAVE
        ST R1, SAVED_R1_SAVE
        ST R2, SAVED_R2_SAVE
        ST R3, SAVED_R3_SAVE
        ST R4, SAVED_R4_SAVE
        ST R5, SAVED_R5_SAVE
        ST R6, SAVED_R6_SAVE
        ST R7, SAVED_R7_SAVE
        ST R2, SAVED_COND_SAVE  ; Condition flags
        ST R3, SAVED_PC_SAVE    ; Save current PC
        
        ; Clear error code
        LEA R0, ERR_NONE
        STR R0, ERROR_CODE, R1
        
        ; Clear current state pointer
        LEA R0, CURRENT_STATE
        STR R0, RECOVERY_PTR, R1
        
        ; Clear state history
        LEA R0, STATE_HISTORY
        LD R1, STATE_HISTORY_SIZE
STATE_CLR_LOOP
        CLR R2
        STR R2, 0(R0)
        ADD R0, R0, #1
        ADD R1, R1, #-1
        BRp STATE_CLR_LOOP
        
        ; Initialize heap pointer
        LEA R0, HEAP_START
        STR R0, CURRENT_STATE, R1
        
        ; Restore registers and return
        LD R0, SAVED_R0_SAVE
        LD R1, SAVED_R1_SAVE
        LD R2, SAVED_R2_SAVE
        LD R3, SAVED_R3_SAVE
        LD R4, SAVED_R4_SAVE
        LD R5, SAVED_R5_SAVE
        LD R6, SAVED_R6_SAVE
        LD R7, SAVED_R7_SAVE
        LD R2, SAVED_COND_SAVE
        LD R3, SAVED_PC_SAVE
        RET

; =============================================================================
; ERROR HANDLER
; =============================================================================
HANDLE_NEXT_ERROR
        ; This is called periodically to check for errors
        ; In a real system, this would monitor hardware interrupts
        ; For simulation, we check for common error conditions
        
        ST R0, SAVED_TRAP_R0
        ST R1, SAVED_TRAP_R1
        ST R2, SAVED_TRAP_R2
        ST R3, SAVED_TRAP_R3
        ST R4, SAVED_TRAP_R4
        ST R5, SAVED_TRAP_R5
        ST R6, SAVED_TRAP_R6
        ST R7, SAVED_TRAP_R7
        ST R2, SAVED_COND
        ST R3, SAVED_PC
        
        ; Check for division by zero (common error case)
        ; Simulate: if R1 == 0, trigger div by zero error
        LD R0, SIM_ERROR_CHECK
        BRz NO_ERROR_CHECKED
        
        ; Simulate error detection
        LD R1, ERR_DIV_ZERO
        STR R1, ERROR_CODE, R2
        LEA R0, ERROR_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
NO_ERROR_CHECKED
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
; =============================================================================
; STATE MANAGEMENT AND RECOVERY
; =============================================================================
SAVE_STATE
        ; Save current register state for recovery
        ST R0, STATE_R0
        ST R1, STATE_R1
        ST R2, STATE_R2
        ST R3, STATE_R3
        ST R4, STATE_R4
        ST R5, STATE_R5
        ST R6, STATE_R6
        ST R7, STATE_R7
        ST R2, STATE_COND
        ST R3, STATE_PC
        RET
        
RESTORE_STATE
        ; Restore state from saved values
        LD R0, STATE_R0
        LD R1, STATE_R1
        LD R2, STATE_R2
        LD R3, STATE_R3
        LD R4, STATE_R4
        LD R5, STATE_R5
        LD R6, STATE_R6
        LD R7, STATE_R7
        LD R2, STATE_COND
        LD R3, STATE_PC
        RET
        
ATTEMPT_RECOVERY
        ; Attempt to recover from error
        LD R0, ERROR_CODE
        BRn RECOVERY_FAILED
        
        ; Check error type and apply appropriate recovery
        LD R1, ERR_DIV_ZERO
        BEQ RECOVERY_DIV_ZERO
        LD R1, ERR_MEM_VIOL
        BEQ RECOVERY_MEM_VIOL
        LD R1, ERR_STACK_OVF
        BEQ RECOVERY_STACK_OVF
        LD R1, ERR_NULL_PTR
        BEQ RECOVERY_NULL_PTR
        
        ; Unknown error - try generic recovery
        LD R0, GENERIC_ERROR_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
RECOVERY_DIV_ZERO
        ; Reset divisor to 1 to prevent division by zero
        LD R0, SAFE_DIVISOR
        STR R0, SAFE_DIVISOR_LOC, R1
        LD R0, RECOVERY_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
RECOVERY_MEM_VIOL
        ; Redirect to safe memory location
        LD R0, SAFE_MEMORY_LOC
        STR R0, SAFE_MEMORY, R1
        LD R0, RECOVERY_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
RECOVERY_STACK_OVF
        ; Restore from previous state
        JSR R7, RESTORE_STATE
        LD R0, RECOVERY_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
RECOVERY_NULL_PTR
        ; Replace with default safe value
        LD R0, SAFE_VALUE
        STR R0, SAFE_POINTER, R1
        LD R0, RECOVERY_MSG
        TRAP x22          ; PUTS
        LD R0, SAVED_TRAP_R0
        LD R1, SAVED_TRAP_R1
        LD R2, SAVED_TRAP_R2
        LD R3, SAVED_TRAP_R3
        LD R4, SAVED_TRAP_R4
        LD R5, SAVED_TRAP_R5
        LD R6, SAVED_TRAP_R6
        LD R7, SAVED_TRAP_R7
        LD R2, SAVED_COND
        LD R3, SAVED_PC
        RET
        
RECOVERY_FAILED
        LD R0, FATAL_ERROR_MSG
        TRAP x22          ; PUTS
        TRAP x25          ; HALT
        RET
        
; =============================================================================
; SAFE EXECUTION UTILITIES
; =============================================================================
EXECUTE_SAFE_OPERATION
        ; Execute an operation with error protection
        JSR R7, SAVE_STATE
        
        ; Try the operation
        JSR R7, PERFORM_COMPUTATION
        BRnz OPERATION_SUCCEEDED
        
        ; If error occurred, attempt recovery
        JSR R7, ATTEMPT_RECOVERY
        
OPERATION_SUCCEEDED
        ; Continue with normal flow
        RET
        
PERFORM_COMPUTATION
        ; Perform a simple safe computation
        LD R0, SAFE_DIVISOR
        ADD R0, R0, #1    ; Increment safely
        STR R0, RESULT, R1
        RET
        
; =============================================================================
; SIMULATION AND DIAGNOSTIC SUPPORT
; =============================================================================
DIAGNOSTIC_MODE
        ; Enable diagnostic mode for debugging
        LD R0, 1
        STR R0, DIAG_MODE, R1
        RET
        
RUN_NORMAL_OPERATION
        ; Run normal operation cycle
        LD R0, OPERATION_COUNT
        ADD R0, R0, #1
        STR R0, OPERATION_COUNT, R1
        RET
        
; =============================================================================
; DATA SECTIONS
; =============================================================================
WELCOME_MSG     .STRINGZ "Self-Healing Tool v1.0 Initialized\n"
INIT_MSG        .STRINGZ "Error handling system active.\n"
ERROR_MSG       .STRINGZ "Error detected - handling...\n"
RECOVERY_MSG    .STRINGZ "Recovery successful.\n"
GENERIC_ERROR_MSG .STRINGZ "Error type not recognized.\n"
FATAL_ERROR_MSG .STRINGZ "Fatal error - system shutting down.\n"

SIM_ERROR_CHECK .FILL x0001     ; Set to 1 to trigger simulated error
ERROR_CODE_LOC  .BLKW 1
SAFE_DIVISOR_LOC .BLKW 1
SAFE_MEMORY     .BLKW 1
SAFE_POINTER    .BLKW 1
DIAG_MODE       .FILL x0000
OPERATION_COUNT .FILL x0000
RESULT          .BLKW 1

STATE_R0        .BLKW 1
STATE_R1        .BLKW 1
STATE_R2        .BLKW 1
STATE_R3        .BLKW 1
STATE_R4        .BLKW 1
STATE_R5        .BLKW 1
STATE_R6        .BLKW 1
STATE_R7        .BLKW 1
STATE_COND      .BLKW 1
STATE_PC        .BLKW 1

SAVED_R0_SAVE   .BLKW 1
SAVED_R1_SAVE   .BLKW 1
SAVED_R2_SAVE   .BLKW 1
SAVED_R3_SAVE   .BLKW 1
SAVED_R4_SAVE   .BLKW 1
SAVED_R5_SAVE   .BLKW 1
SAVED_R6_SAVE   .BLKW 1
SAVED_R7_SAVE   .BLKW 1
SAVED_COND_SAVE .BLKW 1
SAVED_PC_SAVE   .BLKW 1

SAVED_TRAP_R0   .BLKW 1
SAVED_TRAP_R1   .BLKW 1
SAVED_TRAP_R2   .BLKW 1
SAVED_TRAP_R3   .BLKW 1
SAVED_TRAP_R4   .BLKW 1
SAVED_TRAP_R5   .BLKW 1
SAVED_TRAP_R6   .BLKW 1
SAVED_TRAP_R7   .BLKW 1
SAVED_COND      .BLKW 1
SAVED_PC        .BLKW 1

; =============================================================================
; CONSTANTS
; =============================================================================
HEAP_END        .FILL x3FFF
STATE_HISTORY_SIZE .FILL #10
SAFE_DIVISOR    .FILL x0001
SAFE_MEMORY_LOC .FILL x3000
SAFE_VALUE      .FILL x0000
SAFE_MEMORY     .BLKW 1
SAFE_POINTER    .BLKW 1

        .END
