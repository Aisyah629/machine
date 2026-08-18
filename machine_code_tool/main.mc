;; Machine Code Tool - Binary Bytecode Interpreter & Instruction Tracer
;; Format: 32-bit little-endian bytecode
;; Instructions: 8-bit opcode, 4-bit operand size, 20-bit immediate/data

;; Register Definitions
DEFINE R0 0    ; Base Pointer
DEFINE R1 1    ; Stack Pointer
DEFINE R2 2    ; Instruction Pointer
DEFINE R3 3    ; Accumulator
DEFINE R4 4    ; General Purpose 1
DEFINE R5 5    ; General Purpose 2
DEFINE FLAGS 6 ; Condition Flags Register
DEFINE MAX_REGS 16

;; Memory Definitions
DEFINE MEM_SIZE 65536
DEFINE MAX_TRACE 1024

;; Opcodes
DEFINE OP_NOP    0x00
DEFINE OP_HALT   0x01
DEFINE OP_MOV    0x02
DEFINE OP_ADD    0x03
DEFINE OP_SUB    0x04
DEFINE OP_MUL    0x05
DEFINE OP_DIV    0x06
DEFINE OP_AND    0x07
DEFINE OP_OR     0x08
DEFINE OP_NOT    0x09
DEFINE OP_SHL    0x0A
DEFINE OP_SHR    0x0B
DEFINE OP_CMP    0x0C
DEFINE OP_JMP    0x0D
DEFINE OP_JEQ    0x0E
DEFINE OP_JNE    0x0F
DEFINE OP_JLT    0x10
DEFINE OP_JGT    0x11
DEFINE OP_PUSH   0x12
DEFINE OP_POP    0x13
DEFINE OP_CALL   0x14
DEFINE OP_RET    0x15
DEFINE OP_INP    0x16
DEFINE OP_OUT    0x17
DEFINE OP_LOAD   0x18
DEFINE OP_STORE  0x19
DEFINE OP_INC    0x1A
DEFINE OP_DEC    0x1B
DEFINE OP_NEG    0x1C
DEFINE OP_XOR    0x1D
DEFINE OP_SHC    0x1E
DEFINE OP_SHR_S 0x1F

;; Execution State
STATE reg_bank     ; 16 registers
STATE memory       ; 64KB RAM
STATE ip           ; Instruction pointer
STATE sp           ; Stack pointer (starts at MEM_SIZE)
STATE flags        ; ZF, NF, CF, OF
STATE trace_log    ; Execution trace buffer
STATE trace_index  ; Current trace position
STATE running      ; Program running flag
STATE halt_reason  ; Why execution stopped

;; Initialize System
INIT sys_init
    SET reg_bank, #0x00000000, 16
    CLEAR memory, MEM_SIZE
    SET ip, #0
    SET sp, MEM_SIZE
    CLEAR FLAGS
    CLEAR trace_log, MAX_TRACE
    SET trace_index, #0
    SET running, TRUE
    SET halt_reason, #0
END

;; Fetch Instruction
PROC fetch_instruction
    LOAD ip, temp_ip
    LOAD [temp_ip], instr_word
    INCR ip, #1
    RETURN
END

;; Decode Instruction
PROC decode_instruction
    LOAD instr_word, opcode
    LOAD instr_word, operand_size
    LOAD instr_word, operand_data
    RETURN
END

;; Execute Cycle
PROC execute_cycle
    IF NOT running THEN
        SET halt_reason, #HALT_REQUESTED
        RETURN
    ENDIF

    FETCH fetch_instruction
    DECODE decode_instruction

    CASE opcode
        OP_NOP: NOP
        OP_HALT: HALT
        OP_MOV: MOV_IMPL
        OP_ADD: ADD_IMPL
        OP_SUB: SUB_IMPL
        OP_MUL: MUL_IMPL
        OP_DIV: DIV_IMPL
        OP_AND: AND_IMPL
        OP_OR:  OR_IMPL
        OP_NOT: NOT_IMPL
        OP_CMP: CMP_IMPL
        OP_JMP: JMP_IMPL
        OP_JEQ: JEQ_IMPL
        OP_JNE: JNE_IMPL
        OP_JLT: JLT_IMPL
        OP_JGT: JGT_IMPL
        OP_PUSH: PUSH_IMPL
        OP_POP: POP_IMPL
        OP_CALL: CALL_IMPL
        OP_RET: RET_IMPL
        OP_INP: INP_IMPL
        OP_OUT: OUT_IMPL
        OP_LOAD: LOAD_IMPL
        OP_STORE: STORE_IMPL
        OP_INC: INC_IMPL
        OP_DEC: DEC_IMPL
        OP_NEG: NEG_IMPL
        OP_XOR: XOR_IMPL
        OP_SHL: SHL_IMPL
        OP_SHR: SHR_IMPL
    ENDCASE

    TRACE_LOG opcode, ip
    RETURN
END

;; NOP Implementation
PROC NOP
    RETURN
END

;; HALT Implementation
PROC HALT
    SET running, FALSE
    SET halt_reason, #HALT_REQUESTED
    RETURN
END

;; MOV Implementation
PROC MOV_IMPL
    LOAD operand_data, dest_reg
    LOAD operand_data, src_reg
    MOV [dest_reg], [src_reg]
    RETURN
END

;; ADD Implementation
PROC ADD_IMPL
    LOAD operand_data, dest_reg
    LOAD operand_data, src_reg
    ADD [dest_reg], [src_reg]
    UPDATE_FLAGS ZF, NF, CF
    RETURN
END

;; Subtraction, Multiplication, Division follow similar pattern...
;; CMP Implementation
PROC CMP_IMPL
    LOAD operand_data, reg_a
    LOAD operand_data, reg_b
    SUB [reg_a], [reg_b]
    UPDATE_FLAGS ZF, NF, CF, OF
    SUB [reg_b], [reg_a]  ; Restore original value
    RETURN
END

;; Conditional Jump Implementation
PROC JEQ_IMPL
    IF FLAGS.ZF THEN
        LOAD operand_data, target_addr
        SET ip, target_addr
    ENDIF
    RETURN
END

;; Stack Operations
PROC PUSH_IMPL
    DECR sp, #4
    STORE [sp], operand_data
    RETURN
END

PROC POP_IMPL
    LOAD operand_data, [sp]
    INCR sp, #4
    RETURN
END

;; I/O Operations
PROC INP_IMPL
    LOAD operand_data, port_addr
    READ port_addr, data_val
    STORE [operand_data], data_val
    RETURN
END

PROC OUT_IMPL
    LOAD operand_data, port_addr
    LOAD [operand_data], data_val
    WRITE port_addr, data_val
    RETURN
END

;; Memory Operations
PROC LOAD_IMPL
    LOAD operand_data, addr
    LOAD operand_data, dest_reg
    LOAD [addr], [dest_reg]
    RETURN
END

PROC STORE_IMPL
    LOAD operand_data, addr
    LOAD operand_data, src_reg
    STORE [addr], [src_reg]
    RETURN
END

;; Trace Logging
PROC TRACE_LOG
    LOAD trace_index, curr_idx
    STORE [trace_log + curr_idx * 8], opcode
    STORE [trace_log + curr_idx * 8 + 4], ip
    INCR trace_index, #1
    RETURN
END

;; Main Execution Loop
MAIN program_runner
    CALL sys_init
    LABEL run_loop
        CALL execute_cycle
        JUMP run_loop
    LABEL halt_point
        PRINT "Execution Halted"
        PRINT halt_reason
        PRINT trace_index
        FOR i FROM 0 TO trace_index
            PRINT trace_log[i]
        ENDFOR
        HALT
    ENDMAIN

;; Data Segment
DATA program_code
    NOP
    MOV R0, #0x00001000
    MOV R1, #0x00002000
    ADD R2, R0, R1
    CMP R2, #0x00003000
    JNE jump_over
    MOV R3, #0xDEADBEEF
    JMP exit_program
    LABEL jump_over
    MOV R3, #0xCAFEBABE
    LABEL exit_program
    HALT
END_DATA

;; End of Machine Code Tool Specification
