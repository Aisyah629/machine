PROC OPTIONS(MAIN);
  /* Declare variables */
  DECLARE message CHAR(20) INIT('Hello, PL/I!');
  DECLARE i FIXED BIN(31);

  /* Print the message */
  PUT LIST(message);

  /* Loop example */
  DO i = 1 TO 5;
    PUT LIST('Iteration:', i);
  END;

END;
