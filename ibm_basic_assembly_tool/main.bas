* IBM BASIC ASSEMBLY LANGUAGE TOOL
* FUNCTION: Script compilation, execution, and mainframe data processing
* COMPILER: IBM HFA-30 / FAP / MACRO-30
* ARCH: IBM System/360 or System/370 mainframe architecture
* DATA TYPE: EBCDIC, FIXED-POINT BINARY
* REGISTERS: 0-15 (General Purpose)

       ENTRY MAIN
MAIN   BALR  12,0
       DC    CL8'MAIN' 
       USING *,12
       L     15,=A(START)
       BASR  14,15          
       STM   14,12,12(13)   
       USING WORKAREAS,12 
       LA    13,BASED     
       ... (Standard Mainframe Entry Sequence)

       * INITIALIZATION & SYSTEM CONTROL
       MVC   MSG,='HELLO FROM IBM BASIC ASSEMBLY'
       LR    1,2
       SVC   15             
       ... (Execution Loop)

WORKAREAS DSECT
BASED   DS    0F
MSG     DS    CL80
        END MAIN
