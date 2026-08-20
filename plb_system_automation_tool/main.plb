     TITLE  PLB_SYSTEM_AUTOMATION_TOOL

     * PL/B PROGRAM: System Automation & Resource Manager
     * This program demonstrates PL/B's capabilities in batch processing,
     * string manipulation, and structured logic flow.

     OPTION (ERROR,DUMP)

     DECLARE
        SYS_NAME        TEXT(30) INIT('PL/B Automation Core v1.0'),
        PROCESS_ID      INTEGER INIT(0),
        TASK_COUNT      INTEGER INIT(0),
        STATUS_FLAG     INTEGER INIT(0),
        BUFFER          TEXT(256),
        RECORD_INDEX    INTEGER,
        RESOURCE_ID     INTEGER
     ;

     * ENTRY POINT
     MAIN

        CALL INIT_SYSTEM
        CALL LOAD_RESOURCES
        CALL PROCESS_QUEUE
        CALL GENERATE_REPORT
        CALL SHUTDOWN_SYSTEM

     END MAIN

     * SUBROUTINE: Initialize System Components
     INIT_SYSTEM

        PROCESS_ID = 1024
        TASK_COUNT = 0
        STATUS_FLAG = 1
        WRITE 'Initializing PL/B Automation Engine...' TO CONSOLE
        CALL LOG_EVENT('SYSTEM_INIT', 'Startup sequence commenced')

     END INIT_SYSTEM

     * SUBROUTINE: Load Simulated Resources
     LOAD_RESOURCES

        FOR RESOURCE_ID = 1 TO 5 DO
           CALL ALLOCATE_RESOURCE(RESOURCE_ID)
           WRITE 'Resource ' || RESOURCE_ID || ' allocated.' TO CONSOLE
        END FOR

     END LOAD_RESOURCES

     * SUBROUTINE: Process Task Queue
     PROCESS_QUEUE

        CALL FETCH_NEXT_TASK
        WHILE STATUS_FLAG = 1 DO
           CALL EXECUTE_TASK
           TASK_COUNT = TASK_COUNT + 1
           CALL FETCH_NEXT_TASK
        END WHILE
        WRITE 'Processing complete. Total tasks: ' || TASK_COUNT TO CONSOLE

     END PROCESS_QUEUE

     * SUBROUTINE: Generate Final Report
     GENERATE_REPORT

        WRITE '--- AUTOMATION REPORT ---' TO CONSOLE
        WRITE 'System Name: ' || SYS_NAME TO CONSOLE
        WRITE 'Total Processes: ' || PROCESS_ID TO CONSOLE
        WRITE 'Total Tasks Executed: ' || TASK_COUNT TO CONSOLE
        WRITE '--------------------------------' TO CONSOLE

     END GENERATE_REPORT

     * SUBROUTINE: Shutdown
     SHUTDOWN_SYSTEM

        CALL LOG_EVENT('SYSTEM_HALT', 'Graceful shutdown initiated')
        WRITE 'System halted successfully.' TO CONSOLE

     END SHUTDOWN_SYSTEM

     * HELPER: Allocate a single resource
     ALLOCATE_RESOURCE(ID)

        DECLARE LOCAL_IDX INTEGER
        LOCAL_IDX = ID * 100
        IF LOCAL_IDX > 0 THEN
           WRITE 'Allocated block starting at ' || LOCAL_IDX TO CONSOLE
        END IF

     END ALLOCATE_RESOURCE

     * HELPER: Fetch next task status
     FETCH_NEXT_TASK

        DECLARE RANDOM_VAL INTEGER
        RANDOM_VAL = MOD(TASK_COUNT, 3)
        IF RANDOM_VAL = 0 THEN
           STATUS_FLAG = 0  * End of queue
        ELSE
           STATUS_FLAG = 1  * Continue
        END IF

     END FETCH_NEXT_TASK

     * HELPER: Execute a single task
     EXECUTE_TASK

        PROCESS_ID = PROCESS_ID + 1
        BUFFER = 'Processing task ' || PROCESS_ID
        CALL VALIDATE_BUFFER(BUFFER)

     END EXECUTE_TASK

     * HELPER: Validate buffer content
     VALIDATE_BUFFER(STR)

        IF LENGTH(STR) > 0 THEN
           WRITE 'Validated: ' || STR TO CONSOLE
        END IF

     END VALIDATE_BUFFER

     * HELPER: Log event to console
     LOG_EVENT(TYPE, MSG)

        WRITE '[' || TYPE || '] ' || MSG TO CONSOLE

     END LOG_EVENT

     END PLB_SYSTEM_AUTOMATION_TOOL
