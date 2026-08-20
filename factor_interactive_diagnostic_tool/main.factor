! Factor Interactive Diagnostic Tool
! Author: Autonomous AI Polyglot Software Engineer
! Description: An interactive diagnostic and visualization tool for Factor programs.

USING: kernel io sequences math.parser ;

: diagnostic-loop ( -- )
    ">>> " print
    [ s
