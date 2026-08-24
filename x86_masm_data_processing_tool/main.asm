.386
.model flat,stdcall
.stack 4096

; Import standard Win32 API functions
extrn GetStdHandle:PROC
extrn WriteConsoleA:PROC
extrn ReadConsoleA:PROC
extrn ExitProcess:PROC

; Constants
STD_OUTPUT_HANDLE equ -11
STD_INPUT_HANDLE equ -10
MAX_BUFFER_SIZE equ 256

; Data segment
.data
    promptMsg BYTE 'Enter data to process: ', 0
    resultMsg BYTE 'Processed data: ', 0
    newLine BYTE 0Dh, 0Ah, 0
    inputBuffer BYTE MAX_BUFFER_SIZE DUP(?)
    outputBuffer BYTE MAX_BUFFER_SIZE DUP(?)
    dwBytesWritten DWORD ?
    dwBytesRead DWORD ?
    coninHandle DWORD ?
    conoutHandle DWORD ?

; Code segment
.code

; Function: ProcessData
; Description: Performs a simple transformation on the input data
; Input: ECX = pointer to input string
; Output: None (modifies input in place)
ProcessData PROC
    push ebp
    mov ebp, esp
    
    ; Loop through the string until null terminator
    mov esi, ecx
    xor eax, eax
    xor ebx, ebx
    
.process_loop:
    cmp BYTE PTR [esi + ebx], 0
    je .done
    
    ; Simple transformation: invert case or add offset
    mov al, [esi + ebx]
    
    ; Check if character is lowercase
    cmp al, 'a'
    jb .next_char
    cmp al, 'z'
    ja .next_char
    
    ; Convert to uppercase by subtracting 32 (ASCII diff)
    sub al, 32
    mov [esi + ebx], al
    jmp .next_char
    
.next_char:
    inc ebx
    jmp .process_loop
    
.done:
    pop ebp
    ret
ProcessData ENDP

; Main Entry Point
main PROC
    ; Get standard output handle
    push -11
    call GetStdHandle
    mov conoutHandle, eax
    
    ; Get standard input handle
    push -10
    call GetStdHandle
    mov coninHandle, eax
    
    ; Write prompt message
    push 0  ; reserved
    push MAX_BUFFER_SIZE  ; nNumberOfCharsToWrite
    push offset newLine  ; lpBuffer
    push 0  ; lpNumberOfCharsWritten
    push conoutHandle  ; hConsoleOutput
    call WriteConsoleA
    
    ; Read input
    push 0  ; reserved
    push 0  ; lpMode  
    push MAX_BUFFER_SIZE  ; nNumberOfCharsToRead
    push offset inputBuffer  ; lpBuffer
    push coninHandle  ; hConsoleInput
    call ReadConsoleA
    
    ; Process the data
    push offset inputBuffer
    call ProcessData
    
    ; Write result message
    push 0
    push MAX_BUFFER_SIZE
    push offset newLine
    push 0
    push conoutHandle
    call WriteConsoleA
    
    push 0
    call ExitProcess
    
main ENDP

END main
