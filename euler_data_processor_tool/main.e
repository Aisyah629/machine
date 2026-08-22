FUNCTION processData(input_data)
  CLEANED_DATA = []
  FOR item IN input_data DO
    IF isValid(item) THEN
      APPEND CLEANED_DATA TO processItem(item)
    ENDIF
  ENDFOR
  RETURN CLEANED_DATA
ENDFUNCTION

FUNCTION isValid(data)
  IF data != NULL AND data != "" THEN
    RETURN TRUE
  ELSE
    RETURN FALSE
  ENDIF
ENDFUNCTION

FUNCTION processItem(item)
  RETURN TRIM(item) * 2
ENDFUNCTION

MAIN
  DATA = ["  data1  ", "", "data2  ", NULL, "  data3  "]
  RESULT = processData(DATA)
  PRINT RESULT
ENDMAIN
