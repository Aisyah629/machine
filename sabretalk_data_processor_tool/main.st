! SabreTalk Data Processor Tool
! This script demonstrates basic data processing capabilities in SabreTalk.
! It includes functions for parsing, transforming, and validating data strings.

! Define a data processing module
MODULE DataProcessor

! Function to parse a delimited string into a list of items
PROCEDURE ParseData(inputString, delimiter)
    DECLARE parsedList[] AS STRING
    DECLARE currentItem AS STRING
    DECLARE index AS INTEGER

    index = 1
    WHILE index <= LENGTH(inputString) DO
        ! Find the next delimiter
        delimiterPos = INDEX(inputString, delimiter, index)
        
        IF delimiterPos = 0 THEN
            ! No more delimiters, take the rest of the string
            currentItem = SUBSTRING(inputString, index)
            index = LENGTH(inputString) + 1
        ELSE
            ! Extract item up to the delimiter
            currentItem = SUBSTRING(inputString, index, delimiterPos - index)
            index = delimiterPos + 1
        ENDIF
        
        ! Add item to the list
        APPEND(parsedList, currentItem)
    ENDWHILE

    RETURN parsedList
ENDPROCEDURE

! Function to transform data by applying a simple encoding
PROCEDURE TransformData(dataList)
    DECLARE transformedList[] AS STRING
    DECLARE item AS STRING
    DECLARE i AS INTEGER

    FOR i = 1 TO LENGTH(dataList) DO
        item = dataList[i]
        ! Example transformation: Reverse the string
        reversedItem = ""
        FOR j = LENGTH(item) DOWNTO 1 DO
            reversedItem = reversedItem + SUBSTRING(item, j, 1)
        ENDFOR
        APPEND(transformedList, reversedItem)
    ENDFOR

    RETURN transformedList
ENDPROCEDURE

! Function to validate data format (simple example: check length > 0)
PROCEDURE ValidateData(dataList)
    DECLARE validList[] AS STRING
    DECLARE item AS STRING
    DECLARE i AS INTEGER

    FOR i = 1 TO LENGTH(dataList) DO
        item = dataList[i]
        IF LENGTH(item) > 0 THEN
            APPEND(validList, item)
        ENDIF
    ENDFOR

    RETURN validList
ENDPROCEDURE

! Main execution block
BEGIN
    DECLARE sampleData AS STRING
    DECLARE delimiter AS STRING
    DECLARE parsedData[] AS STRING
    DECLARE transformedData[] AS STRING
    DECLARE validatedData[] AS STRING

    ! Sample data: Comma-separated values
    sampleData = "Hello,World,SabreTalk,Data,Processing"
    delimiter = ","

    ! Parse the data
    parsedData = ParseData(sampleData, delimiter)
    PRINT "Parsed Data: "
    FOR i = 1 TO LENGTH(parsedData) DO
        PRINT "  - " + parsedData[i]
    END

    ! Transform the data
    transformedData = TransformData(parsedData)
    PRINT "Transformed Data: "
    FOR i = 1 TO LENGTH(transformedData) DO
        PRINT "  - " + transformedData[i]
    END

    ! Validate the data
    validatedData = ValidateData(parsedData)
    PRINT "Validated Data: "
    FOR i = 1 TO LENGTH(validatedData) DO
        PRINT "  - " + validatedData[i]
    END
END
