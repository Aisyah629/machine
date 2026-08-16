// Legacy Database Migration and Integrity Verification Module
// Language: Clipper
// Author: Autonomous AI Polyglot Software Engineer

#include "file.ch"
#include "dbrtl.ch"
#include "inkey.ch"
#include "memvar.ch"

// Global Variables
GLOBAL g_cSourceDBF := ""
GLOBAL g_cTargetDBF := ""
GLOBAL g_cLogfile := ""
GLOBAL g_nRecordsProcessed := 0
GLOBAL g_nRecordsFailed := 0

// Main Entry Point
FUNCTION Main()
    LOCAL lContinue := .T.
    
    SET TALK OFF
    SET ECHO OFF
    SET CONSOLE ON
    
    ? "==========================================="
    ? "  Legacy Database Migration & Integrity Verification"
    ? "  Clipper Tool v1.0"
    ? "==========================================="
    ?
    
    // Initialize system
    IF ! INIT_SYSTEM()
        RETURN NIL
    ENDIF
    
    // Main Loop
    WHILE lContinue
        @ 5, 10 SAY "Select Option:"
        @ 6, 10 SAY "1. Configure Migration"
        @ 7, 10 SAY "2. Run Migration"
        @ 8, 10 SAY "3. Verify Integrity"
        @ 9, 10 SAY "4. Generate Report"
        @ 10, 10 SAY "5. Exit"
        @ 11, 10 SAY ""
        @ 12, 10 GET g_nChoice DEFAULT 5 PICTURE "99"
        
        READ
        
        DO CASE
            CASE g_nChoice == 1
                CONFIGURE_MIGRATION()
            CASE g_nChoice == 2
                IF ! EMPTY(g_cSourceDBF) .AND. ! EMPTY(g_cTargetDBF)
                    RUN_MIGRATION()
                ELSE
                    ? "Error: Source and Target databases must be configured."
                ENDIF
            CASE g_nChoice == 3
                VERIFY_INTEGRITY()
            CASE g_nChoice == 4
                GENERATE_REPORT()
            CASE g_nChoice == 5
                lContinue := .F.
                SHUTDOWN_SYSTEM()
            OTHERWISE
                ? "Invalid option. Please try again."
        ENDCASE
        
        @ 20, 10 SAY "Press any key to continue..."
        INKEY(0)
        CLS
    ENDWHILE
    
    RETURN NIL

// Initialize System
FUNCTION INIT_SYSTEM()
    g_nRecordsProcessed := 0
    g_nRecordsFailed := 0
    g_cLogfile := "MIGRATION_LOG.TXT"
    
    // Open log file
    IF FILE(g_cLogfile)
        ERASE (g_cLogfile)
    ENDIF
    
    g_hLog := FOPEN(g_cLogfile)
    IF g_hLog == -1
        ? "Error: Cannot open log file " + g_cLogfile
        RETURN .F.
    ENDIF
    
    LOG_ENTRY("System initialized")
    
    // Set database driver
    SET DRIVER TO "DBFCDX"
    
    RETURN .T.

// Shutdown System
FUNCTION SHUTDOWN_SYSTEM()
    // Close all open databases
    USE
    
    // Close log file
    IF g_hLog >= 0
        FCLOSE(g_hLog)
    ENDIF
    
    LOG_ENTRY("System shutdown")
    ? "System shutdown complete."
    RETURN NIL

// Configure Migration
PROCEDURE CONFIGURE_MIGRATION()
    LOCAL cSource, cTarget
    
    CLS
    ? "Configure Migration"
    ? "==================="
    ?
    
    @ 3, 10 SAY "Source Database Path:"
    @ 4, 10 GET g_cSourceDBF PICTURE "!"
    
    @ 5, 10 SAY "Target Database Path:"
    @ 6, 10 GET g_cTargetDBF PICTURE "!"
    
    READ
    
    IF ! EMPTY(g_cSourceDBF) .AND. ! EMPTY(g_cTargetDBF)
        LOG_ENTRY("Migration configured: Source=" + g_cSourceDBF + " Target=" + g_cTargetDBF)
        ? "Configuration saved."
    ELSE
        ? "Error: Both source and target must be specified."
    ENDIF
    
    RETURN

// Run Migration
PROCEDURE RUN_MIGRATION()
    LOCAL lSuccess := .T.
    
    CLS
    ? "Running Migration"
    ? "================="
    ?
    
    // Open source database
    IF ! USE_SOURCE_DB()
        lSuccess := .F.
    ENDIF
    
    // Create and open target database
    IF lSuccess .AND. ! CREATE_TARGET_DB()
        lSuccess := .F.
    ENDIF
    
    // Perform migration
    IF lSuccess
        lSuccess := PERFORM_MIGRATION()
    ENDIF
    
    // Close databases
    USE
    
    IF lSuccess
        ? "Migration completed successfully."
        LOG_ENTRY("Migration completed successfully")
    ELSE
        ? "Migration failed. Check log file."
        LOG_ENTRY("Migration failed")
    ENDIF
    
    ? "Records processed: " + ALLTRIM(STR(g_nRecordsProcessed))
    ? "Records failed: " + ALLTRIM(STR(g_nRecordsFailed))
    
    RETURN

// Use Source Database
FUNCTION USE_SOURCE_DB()
    LOCAL lSuccess := .T.
    
    IF ! FILE(g_cSourceDBF)
        ? "Error: Source database not found: " + g_cSourceDBF
        LOG_ENTRY("Error: Source database not found")
        RETURN .F.
    ENDIF
    
    IF ! USE (g_cSourceDBF) ALIAS "SRC" NEW
        ? "Error: Cannot open source database"
        LOG_ENTRY("Error: Cannot open source database")
        RETURN .F.
    ENDIF
    
    // Set up source fields for migration
    FIELDLIST := FIELDS()
    
    LOG_ENTRY("Source database opened")
    RETURN .T.

// Create Target Database
FUNCTION CREATE_TARGET_DB()
    LOCAL lSuccess := .T.
    
    // Create structure in target
    IF FILE(g_cTargetDBF)
        ERASE (g_cTargetDBF)
    ENDIF
    
    // Copy structure from source
    USE (g_cSourceDBF)
    COPY STRUCTURE TO (g_cTargetDBF)
    
    // Open target database
    IF ! USE (g_cTargetDBF) ALIAS "TGT" NEW
        ? "Error: Cannot open target database"
        LOG_ENTRY("Error: Cannot open target database")
        RETURN .F.
    ENDIF
    
    LOG_ENTRY("Target database created and opened")
    RETURN .T.

// Perform Migration
FUNCTION PERFORM_MIGRATION()
    LOCAL nTotal, nCurrent
    
    IF RECNO("SRC") > 0 .AND. EOF("SRC")
        ? "Source database is empty."
        RETURN .T.
    ENDIF
    
    // Count records
    nTotal := RECCOUNT("SRC")
    
    IF nTotal == 0
        ? "No records to migrate."
        RETURN .T.
    ENDIF
    
    ? "Migrating " + ALLTRIM(STR(nTotal)) + " records..."
    
    // Process each record
    SCAN
        g_nRecordsProcessed++
        
        IF ! ADD_RECORD_TO_TARGET()
            g_nRecordsFailed++
            LOG_ENTRY("Failed to process record: " + ALLTRIM(STR(RECNO("SRC"))))
        ENDIF
        
        // Show progress
        IF MOD(g_nRecordsProcessed, 100) == 0
            ? "Processed " + ALLTRIM(STR(g_nRecordsProcessed)) + " / " + ALLTRIM(STR(nTotal))
        ENDIF
    ENDSCAN
    
    // Sync and close target
    SYNC("TGT")
    
    LOG_ENTRY("Migration processed " + ALLTRIM(STR(g_nRecordsProcessed)) + " records, " + ALLTRIM(STR(g_nRecordsFailed)) + " failed")
    RETURN .T.

// Add Record to Target
FUNCTION ADD_RECORD_TO_TARGET()
    LOCAL cFields, cValues, lSuccess := .T.
    
    SELECT "TGT"
    APPEND BLANK
    
    // Transfer fields
    DO WHILE ! EOF("SRC")
        IF RECNO("SRC") != g_nRecordsProcessed + 1
            SKIP 1
            LOOP
        ENDIF
        
        FOR EACH field IN FIELDLIST
            IF EMPTY(field)
                LOOP
            ENDIF
            
            @ RECCOUNT("TGT") + 1, 1 OF "TGT" PUT field NAME
        NEXT
        
        @ RECCOUNT("TGT") + 1, 1 OF "TGT" PUT ""
        
        IF ! BLANK("TGT")
            ? "Error: Record transfer failed"
            lSuccess := .F.
            EXIT
        ENDIF
    ENDDO
    
    SELECT "SRC"
    
    RETURN lSuccess

// Verify Integrity
PROCEDURE VERIFY_INTEGRITY()
    CLS
    ? "Verifying Integrity"
    ? "==================="
    ?
    
    IF EMPTY(g_cSourceDBF) .OR. EMPTY(g_cTargetDBF)
        ? "Error: Source and target databases must be configured."
        RETURN
    ENDIF
    
    IF ! FILE(g_cSourceDBF) .OR. ! FILE(g_cTargetDBF)
        ? "Error: One or both database files not found."
        RETURN
    ENDIF
    
    LOCAL nSourceRecs, nTargetRecs
    
    USE (g_cSourceDBF)
    nSourceRecs := RECCOUNT()
    USE
    
    USE (g_cTargetDBF)
    nTargetRecs := RECCOUNT()
    USE
    
    ? "Source records: " + ALLTRIM(STR(nSourceRecs))
    ? "Target records: " + ALLTRIM(STR(nTargetRecs))
    
    IF nSourceRecs == nTargetRecs
        ? "Integrity check PASSED: Record counts match."
        LOG_ENTRY("Integrity check passed: Record counts match")
    ELSE
        ? "Integrity check FAILED: Record counts do not match."
        LOG_ENTRY("Integrity check failed: Record counts do not match")
    ENDIF
    
    RETURN

// Generate Report
PROCEDURE GENERATE_REPORT()
    LOCAL cReportFile := "MIGRATION_REPORT.TXT"
    
    CLS
    ? "Generating Report"
    ? "================="
    ?
    
    LOCAL hFile := FCREATE(cReportFile)
    IF hFile == -1
        ? "Error: Cannot create report file."
        RETURN
    ENDIF
    
    FWRITE(hFile, "Migration Report\n")
    FWRITE(hFile, "================\n\n")
    FWRITE(hFile, "Date: " + DTOC(DATE()) + "\n")
    FWRITE(hFile, "Time: " + TTOC(TIME()) + "\n\n")
    FWRITE(hFile, "Source: " + g_cSourceDBF + "\n")
    FWRITE(hFile, "Target: " + g_cTargetDBF + "\n\n")
    FWRITE(hFile, "Records Processed: " + ALLTRIM(STR(g_nRecordsProcessed)) + "\n")
    FWRITE(hFile, "Records Failed: " + ALLTRIM(STR(g_nRecordsFailed)) + "\n")
    FWRITE(hFile, "\nStatus: " + IF(g_nRecordsFailed == 0, "SUCCESS", "FAILED") + "\n")
    
    FCLOSE(hFile)
    
    ? "Report generated: " + cReportFile
    LOG_ENTRY("Report generated: " + cReportFile)
    
    RETURN

// Log Entry
FUNCTION LOG_ENTRY(cMessage)
    LOCAL hFile := FOPEN(g_cLogfile, 2)  // 2 = append
    IF hFile >= 0
        FWRITE(hFile, DTOC(DATE()) + " " + TTOC(TIME()) + " " + cMessage + CHR(13) + CHR(10))
        FCLOSE(hFile)
    ENDIF
    RETURN NIL
