-- MaxScript Tool Main Entry Point
-- This script initializes the MaxScript tool environment and provides core functionality for 3ds Max integration.

if (classOf MAXHost == MAXClass) then
(
    -- Initialize logging
    fn logMessage msg = (
        local f = createFile "maxscript_tool/tool.log"
        format "% - %\n" (timestamp()) msg to:f
        close f
    )

    -- Core execution engine
    fn executeScript scriptPath = (
        if doesFileExist scriptPath then
        (
            try
            (
                source scriptPath
                logMessage "Successfully executed: " + scriptPath
                return true
            )
            catch (err)
            (
                logMessage "Execution error in " + scriptPath + ": " + err
                return false
            )
        )
        else
        (
            logMessage "File not found: " + scriptPath
            return false
        )
    )

    -- Validation function
    fn validateScript scriptContent = (
        local errors = #()
        local lines = splitString scriptContent "\n"
        for i = 1 to lines.count do
        (
            local line = lines[i]
            if (strip line == "") or (line[1] == "--") then continue
            if not (matchPattern line pattern:"(?i)(fn|global|local|if|else|while|for|struct|class|enum|try|catch|return|format|delete|create|open|close|read|write)") then
                append errors ("Line " + i as string + ": Syntax warning or unrecognized statement: " + line)
        )
        return errors
    )

    -- Main execution block
    format "MaxScript Tool Initialized Successfully\n"
    format "Ready to process .ms files.\n"
    
    -- Example usage placeholder
    -- executeScript "scripts/example.ms"
    -- validateScript (getScriptString #script)
) else
(
    format "Warning: Running outside of 3ds Max environment. Some features may be limited.\n"
    format "MaxScript Tool Initialized.\n"
)
