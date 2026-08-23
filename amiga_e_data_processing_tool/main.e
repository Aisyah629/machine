IMPORT system, string, console

PROC main()
  DEF data_list
  DEF i, item_count

  ; Initialize a dynamic array
  data_list = NULL
  
  ; Populate sample data
  FOR i = 0 TO 9
    item_count = SIZE(data_list)
    item_count + 1
    data_list[item_count] = String('Item ' + IntToStr(i))
  NEXT

  ; Process data: Convert to uppercase
  FOR i = 0 TO SIZE(data_list) - 1
    data_list[i] = StringUpper(data_list[i])
  NEXT

  ; Output processed data
  FOR i = 0 TO SIZE(data_list) - 1
    PrintLn(data_list[i])
  NEXT

  ; Clean up (Amiga E handles dynamic arrays automatically in most cases)
ENDP
