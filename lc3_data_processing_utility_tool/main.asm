.ORIG x3000

; LC-3 Data Processing Utility
; This program demonstrates basic data processing routines.

; Registers:
; R0: General purpose
; R1: Loop counter
; R2: Data pointer
; R3: Temporary
; R4: Input/Output

; Data Section
DATA_START .FILL x0010
DATA_END   .FILL x0020
COUNT      .FILL x0005
RESULT     .BLKW x0010

; Start of Program
START      LEA R2, DATA_START  ; Load starting address of data array
           LEA R4, RESULT    ; Load starting address of result array
           LD  R1, COUNT     ; Load loop count (5)

PROCESS_LOOP LDU R3, R2     ; Load current data (unsigned)
           ADD R5, R3, #5    ; Example processing: add 5
           STD R5, R4      ; Store result
           ADD R2, R2, #1  ; Increment data pointer
           ADD R4, R4, #1  ; Increment result pointer
           ADD R1, R1, #-1 ; Decrement loop counter
           BRp PROCESS_LOOP ; If not zero, continue

           HALT

; End of Program
.DATA
DATA_START .FILL x0010
DATA_END   .FILL x0020
COUNT      .FILL x0005
RESULT     .BLKW x0010

.TRAP x25 ; TRAP RTI
