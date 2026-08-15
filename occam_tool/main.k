-- Occam Tool Main Program
-- This program demonstrates basic Occam syntax and structure.

PROC main (CHAN OF INT channel)
  INT x
  x := 1
  WHILE TRUE
    PAR
      channel ! 1
      channel ! x
      channel ! x + 2
    INT y
    y := channel ? y
    PRINT (y, NL, "\n")
  DONE
