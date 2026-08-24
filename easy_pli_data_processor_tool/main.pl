/*
  Easy PL/I Data Processor Tool
  -----------------------------
  This program demonstrates a simple data processing pipeline
  using Easy PL/I. It reads data, processes it, and outputs results.
*/

/* Define the data structure for records */
DCL 1 record,
    2 name    CHAR(20),
    2 id      FIXED DEC(5),
    2 value   FIXED DEC(10,2);

/* Define counters and flags */
DCL 1 counter FIXED DEC(5) INIT(0);
DCL 1 eof_flag  LOGICAL INIT(FALSE);

/* Main Procedure */
PROCESSING: PROCEDURE OPTIONS(MAIN);\n
  /* Display header */
  PUT SKIP LINE('Easy PL/I Data Processor');
  PUT SKIP LINE('----------------------------');

  /* Initialize processing loop */
  DO WHILE (eof_flag = FALSE);
    
    /* Read a record */
    READ FILE(INPUT) INTO(record);
    
    /* Check for end of file */
    IF INPUT_STATUS() = 'END' THEN DO;
      eof_flag = TRUE;
      LEAVE;
    END;
    
    /* Process the record */
    PROCESS_RECORD(record);
    
    counter = counter + 1;
  END;

  /* Display summary */
  PUT SKIP LINE('Processing complete.');
  PUT SKIP LINE('Records processed: ' || STRING(counter, FIXED));

  RETURN;

END PROCESSING;

/* Procedure to process a single record */
PROCESS_RECORD: PROCEDURE(rec);\n  DCL rec LIKE(record);
  
  /* Example transformation: double the value */
  rec.value = rec.value * 2;
  
  /* Output processed record */
  PUT SKIP LIST('Processed:', rec.name, rec.id, rec.value);

END PROCESS_RECORD;
