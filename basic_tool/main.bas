10 REM Basic Tool - Text File Parser and Report Generator
20 REM Version 1.0
30 
40 DIM lines(1000)
50 DIM records(100)
60 DIM fields(20)
70 
80 INPUT "Enter filename: ", filename$
90 INPUT "Enter delimiter: ", delim$
100 
110 open filename$ for input as #1
120 linecount = 0
130 
140 WHILE NOT EOF(1)
150 LINE INPUT #1, line$
160 linecount = linecount + 1
170 IF linecount > 1000 THEN PRINT "File too large": GOTO 200
180 lines(linecount) = line$
190 WEND
200 CLOSE #1
210 
220 PRINT "Parsing " + STR$(linecount) + " lines..."
230 
240 totalfields = 0
250 FOR i = 1 TO linecount
260   n = PARSE(lines(i), delim$, fields())
270   totalfields = totalfields + n
280 NEXT i
290 
300 PRINT "Report Generated:"
310 PRINT "Total lines processed: " + STR$(linecount)
320 PRINT "Total fields found: " + STR$(totalfields)
330 PRINT "Average fields per line: " + STR$(totalfields / linecount)
340 
350 END
360 
370 DEF PARSE(str$, delim$, arr())
380   cnt = 0
390   current$ = ""
400   FOR j = 1 TO LEN(str$)
410     ch$ = MID$(str$, j, 1)
420     IF ch$ = delim$ THEN
430       cnt = cnt + 1
440       arr(cnt) = current$
450       current$ = ""
460     ELSE
470       current$ = current$ + ch$
480     END IF
490   NEXT j
500   cnt = cnt + 1
510   arr(cnt) = current$
520   PARSE = cnt
530 END DEF
