-- 
-- PEARL Program: Real-Time Embedded System Simulation and Task Scheduling
-- Language: PEARL (Procedure and Event-oriented Abstract Language for Real-Time systems)
-- Purpose: Demonstrates task declaration, event handling, and a simplified scheduling loop.
--

PROGRAM RealTimeSimulation

-- Task Configuration
TASK PeriodicTask TYPE REAL_TIME_TASK
    PERIOD 100
    PRIORITY 1
    TASK_BODY PeriodicTaskBody
END_TASK

TASK AperiodicTask TYPE REAL_TIME_TASK
    PRIORITY 2
    TASK_BODY AperiodicTaskBody
END_TASK

EVENT StartSignal TYPE EVENT
    PRIORITY 1
END_EVENT

EVENT EndSignal TYPE EVENT
    PRIORITY 2
END_EVENT

EVENT TickSignal TYPE EVENT
    PRIORITY 3
END_EVENT

-- Task Bodies
TASK_BODY PeriodicTaskBody
    INTEGER LocalCounter
    BEGIN
        LocalCounter := 0
        REPEAT
            -- Simulate work
            LocalCounter := LocalCounter + 1
            PRINT "Periodic Task: Iteration " & LocalCounter
            WAIT_FOR EndSignal
        END_REPEAT
    END_TASK_BODY

TASK_BODY AperiodicTaskBody
    BEGIN
        REPEAT
            PRINT "Aperiodic Task: Waiting for Trigger"
            WAIT_FOR StartSignal
            PRINT "Aperiodic Task: Triggered"
            -- Simulate processing
            WAIT_FOR EndSignal
        END_REPEAT
    END_TASK_BODY

-- Main Program Flow
BEGIN
    PRINT "Real-Time Embedded System Simulation Started"

    -- Create and Start Tasks
    CREATE PeriodicTask
    CREATE AperiodicTask

    START PeriodicTask
    -- AperiodicTask waits for StartSignal

    -- Simulation Loop
    PRINT "Simulation Loop: Sending Tick Signals"
    INTEGER TickCount
    TickCount := 0
    REPEAT
        WAIT_FOR TickSignal
        TickCount := TickCount + 1
        PRINT "Tick: " & TickCount

        -- Trigger Aperiodic Task every 5 ticks
        IF TickCount MOD 5 = 0 THEN
            SIGNAL StartSignal
        END_IF

        -- End simulation after 20 ticks
        IF TickCount >= 20 THEN
            SIGNAL EndSignal
            EXIT
        END_IF
    END_REPEAT

    PRINT "Simulation Ended"
END_PROGRAM
