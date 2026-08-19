BEGIN Karel Edu Simulation Tool

GLOBAL CONSTANTS:
    GRID_WIDTH = 10
    GRID_HEIGHT = 10
    MAX_STEPS = 1000

GLOBAL VARIABLES:
    worldGrid[GRID_HEIGHT][GRID_WIDTH]
    karelPos[2] = [0, 0]
    karelDir = NORTH
    beeperBag = 0
    stepCounter = 0

FUNCTIONS:
    INIT_GRID():
        CLEAR worldGrid
        FOR y FROM 0 TO GRID_HEIGHT-1:
            FOR x FROM 0 TO GRID_WIDTH-1:
                worldGrid[y][x] = EMPTY

    MOVE_FORWARD():
        newPosX = karelPos[0]
        newPosY = karelPos[1]
        IF karelDir == NORTH:
            newPosY = newPosY - 1
        ELSE IF karelDir == SOUTH:
            newPosY = newPosY + 1
        ELSE IF karelDir == WEST:
            newPosX = newPosX - 1
        ELSE IF karelDir == EAST:
            newPosX = newPosX + 1

        IF newPosX < 0 OR newPosX >= GRID_WIDTH OR newPosY < 0 OR newPosY >= GRID_HEIGHT:
            LOG ERROR "Attempted to move outside grid boundaries."
            RETURN FALSE
        ELSE IF worldGrid[newPosY][newPosX] == WALL:
            LOG ERROR "Attempted to move into a wall."
            RETURN FALSE
        ELSE:
            karelPos[0] = newPosX
            karelPos[1] = newPosY
            stepCounter = stepCounter + 1
            LOG INFO "Moved to [" + newPosX + ", " + newPosY + "]"
            RETURN TRUE

    TURN_LEFT():
        CASE karelDir:
            NORTH: karelDir = WEST
            WEST: karelDir = SOUTH
            SOUTH: karelDir = EAST
            EAST: karelDir = NORTH
        LOG INFO "Turned left. New direction: " + karelDir
        stepCounter = stepCounter + 1

    PICK_BEEPER():
        IF worldGrid[karelPos[1]][karelPos[0]] == BEEPER:
            worldGrid[karelPos[1]][karelPos[0]] = EMPTY
            beeperBag = beeperBag + 1
            LOG INFO "Picked up beeper. Bag count: " + beeperBag
        ELSE:
            LOG ERROR "No beeper present at current location."

    PUT_BEEPER():
        IF beeperBag > 0:
            IF worldGrid[karelPos[1]][karelPos[0]] == EMPTY:
                worldGrid[karelPos[1]][karelPos[0]] = BEEPER
                beeperBag = beeperBag - 1
                LOG INFO "Placed beeper. Bag count: " + beeperBag
            ELSE:
                LOG ERROR "Beepers already exist at this location."
        ELSE:
            LOG ERROR "Beeper bag is empty."

    EXECUTE_PROGRAM(programCode):
        stepCounter = 0
        PARSE programCode INTO commands
        FOR EACH cmd IN commands:
            IF stepCounter >= MAX_STEPS:
                LOG ERROR "Maximum step limit reached. Execution halted."
                BREAK
            SWITCH cmd.type:
                CASE MOVE:
                    IF NOT MOVE_FORWARD(): BREAK
                CASE TURN_LEFT:
                    TURN_LEFT()
                CASE PICK:
                    PICK_BEEPER()
                CASE PUT:
                    PUT_BEEPER()
        LOG INFO "Program execution completed. Total steps: " + stepCounter

BEGIN MAIN:
    INIT_GRID()
    LOG INFO "Karel Educational Simulator Initialized."
    LOG INFO "Grid Size: " + GRID_WIDTH + "x" + GRID_HEIGHT
    LOG INFO "Ready for input..."
END
