/*
 * TADS 3 Data Processing Utility
 * 
 * This is a basic data processing utility written in TADS 3.
 * It demonstrates file reading, string manipulation, and simple data aggregation.
 */

globalDataProcessingTool: CommandObject 'process' 'process'
    "Process data from a specified file.\n"
    
    verify() { }
    
    action()
    {
        local inputFileName = gQObj;
        local fileHandle = nil;
        local allLines = nil;
        local dataDict = nil;
        
        // Initialize data dictionary
        dataDict = new Dictionary();
        
        // Check if filename was provided
        if (inputFileName == nil)
        {
            "Usage: process <filename>\n";
            return;
        }
        
        // Open the file
        try
        {
            fileHandle = new File();
            fileHandle.open(inputFileName, FileExists ? 'r' : nil);
        }
        catch (Exception exc)
        {
            "Error opening file: <<exc.toString()>>\n";
            return;
        }
        
        // If file doesn't exist or couldn't be opened
        if (fileHandle == nil || !fileHandle.isOpen())
        {
            "File not found or unable to open: <<inputFileName>>\n";
            return;
        }
        
        "Opening file: <<inputFileName>>\n";
        
        // Read all lines
        allLines = fileHandle.readAll();
        
        // Process each line
        local lineNum = 1;
        local totalLines = 0;
        local processedLines = 0;
        
        while (allLines.hasMoreElements())
        {
            local line = allLines.next();
            totalLines++;
            
            // Skip empty lines
            if (line == nil || line.trim() == '')
                continue;
            
            // Simple tokenization by whitespace
            local tokens = line.trim().split(/\s+/);
            
            // Use first token as key, rest as value array
            if (tokens.length > 0)
            {
                local key = tokens[1];
                local values = tokens.slice(2);
                
                // Add to dictionary
                if (dataDict[key] == nil)
                    dataDict[key] = [];
                
                dataDict[key].append(values);
                processedLines++;
            }
        }
        
        fileHandle.close();
        
        "\nProcessing complete.\n";
        "Total lines read: <<totalLines>>\n";
        "Lines with data: <<processedLines>>\n";
        "Unique keys found: <<dataDict.size()>>\n";
        
        // Display summary
        "\n--- Data Summary ---\n";
        local keys = dataDict.keys();
        while (keys.hasMoreElements())
        {
            local key = keys.next();
            local valList = dataDict[key];
            "Key: <<key>>, Records: <<valList.length()>>\n";
        }
        
        "\nDone.\n";
    }
    ;

/*
 * Global Initialization
 */
versionInfo = gameName + ' version ' + gameVersion + ' (' + (tadsVersion >> 16) + '.' + ((tadsVersion >> 8) & 0xff) + '.' + (tadsVersion & 0xff) + ', ' + libVersion + '/' + libFile + ')'
libraryMech = VersionMech;

modify GameMain
    gameName = 'TADS Data Processor'
    gameVersion = '1.0'
    startLocation = startRoom
    ;

global startRoom: Room 'Start Room' 'Start Room'
    "You are in a simple starting room. Use 'process' to process data files.\n"
    ;

/*
 * Main Initialization
 */
gameMain: GameMainDef
    initialPlayerChar = me
    ;

me: Actor 'you' 'you'
    properName = 'User'
    ;
