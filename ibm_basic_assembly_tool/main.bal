      ENTRY MAIN
      SAVE  (14,12)
      USING  *,14
      LA    15,AREA1(4096)
      STM   14,12,12(13)
      B     START
      AREA  *,DP
START  EQU   *
      LA    1,MSG       Load address of message
      XPRNT MSG,40      Print message to console
      LR    15,0        Set return code to 0
      LM    14,12,12(13)
      RETURN (14,12)
      END
MSG    DC    C'HELLO FROM IBM BASIC ASSEMBLY'
      END
