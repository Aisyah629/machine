BEGIN
  % Data Process 187 Tool %
  % Specialized data processing utility %

  INTEGER MAX_RECORDS, FIELD_LENGTH, ERROR_CODE;
  REAL AVG_SCORE;
  ARRAY RECORDS(1:100) OF STRUCTURE;
  ARRAY FIELDS(1:5) OF CHARACTER(20);

  BEGIN
    % Initialization %
    MAX_RECORDS := 0;
    FIELD_LENGTH := 20;
    ERROR_CODE := 0;
    AVG_SCORE := 0.0;

    % Process Data %
    FOR I := 1 TO 100 DO
      BEGIN
        % Validate Record %
        IF VALIDATE(RECORDS(I)) THEN
          BEGIN
            MAX_RECORDS := MAX_RECORDS + 1;
            TRANSFORM(RECORDS(I));
            AVG_SCORE := AVG_SCORE + RECORDS(I).SCORE;
          END
        ELSE
          ERROR_CODE := ERROR_CODE + 1;
      END;

    % Calculate Average %
    IF MAX_RECORDS > 0 THEN
      AVG_SCORE := AVG_SCORE / REAL(MAX_RECORDS);

    % Output Results %
    PRINT("Processed Records: ", MAX_RECORDS);
    PRINT("Errors: ", ERROR_CODE);
    PRINT("Average Score: ", AVG_SCORE);

  END;

  % Validation Function %
  FUNCTION VALIDATE(R)
    STRUCTURE R;
    BEGIN
      BOOLEAN RESULT;
      RESULT := (R.ID > 0) AND (R.NAME /= "");
      VALIDATE := RESULT;
    END;

  % Transform Function %
  PROCEDURE TRANSFORM(R)
    STRUCTURE R;
    BEGIN
      R.UPPER_NAME := TO_UPPER(R.NAME);
      R.ADJUSTED_SCORE := R.SCORE * 1.1;
    END;

END
