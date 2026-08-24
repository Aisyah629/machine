.ORIG x3000

; LC-3 Data Processor Tool
; A simple utility to demonstrate data processing logic in LC-3.
; This tool reads a number, adds a constant offset (simulating a data transformation),
; and stores the result.

; Constants
OFFSET .FILL x0005    ; Data offset value to add

; Registers and Memory for processing
INPUT_VAL  .BLKW 1    ; Buffer for input data
RESULT_VAL .BLKW 1    ; Buffer for processed data

; Main Entry Point
MAIN
    ; Load the offset into R1
    LD R1, OFFSET

    ; For demonstration purposes, we initialize a sample data value in R0
    ; In a real scenario, this would come from input (TRAP x23)
    LEA R0, SAMPLE_DATA
    LDR R0, R0, #0      ; Load sample data into R0

    ; Save input to memory buffer
    STR R0, INPUT_VAL, #0

    ; Perform Data Processing: Add Offset
    ADD R2, R0, R1      ; R2 = R0 + OFFSET

    ; Save result to memory buffer
    STR R2, RESULT_VAL, #0

    ; Halt execution
    HALT

; Data definitions
SAMPLE_DATA .FILL x000A ; Sample input value (10)

; End of program
.END
