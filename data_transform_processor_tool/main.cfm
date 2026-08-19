<cfparam name="attributes.action" default="process">

<!--- Logger Helper for simple logging without external CFCs --->
<cfcomponent output="false">
    <cffunction name="log" access="public" returntype="void">
        <cfargument name="level" type="string" required="true">
        <cfargument name="message" type="string" required="true">
        <cfargument name="details" type="string" required="false" default="">
        <cfdump var="#arguments#" output="console" label="DataTransformLog">
    </cffunction>
</cfcomponent>

<cfscript>
    // Initialize the tool
    processor = createObject("component", "data_transform_processor_tool").init();
    processor.loadConfig();
    
    // Sample data for demonstration
    sampleData = [
        {
            "id": 1,
            "name": "  Alice Smith  ",
            "email": "alice@example.com",
            "created_at": "2023-10-27 10:00:00",
            "age": "29"
        },
        {
            "id": 2,
            "name": "Bob Jones",
            "email": "",
            "created_at": "invalid-date",
            "age": "not-a-number"
        },
        {
            "id": 3,
            "name": "Charlie Brown",
            "email": "charlie@example.com",
            "created_at": "2023-10-28",
            "age": "35"
        }
    ];

    schema = {
        "id": true,
        "name": true,
        "email": true
    };

    // Step 1: Clean Data
    cleanData = processor.cleanData(sampleData);
    writeOutput("<h2>Cleaned Data:</h2><pre>#serializeJSON(cleanData, true)#</pre><hr>");

    // Step 2: Validate Schema
    validRecords = [];
    invalidRecords = [];
    for (record in cleanData) {
        if (processor.validateSchema(record, schema)) {
            arrayAppend(validRecords, record);
        } else {
            arrayAppend(invalidRecords, record);
        }
    }
    writeOutput("<h2>Valid Records: #arrayLen(validRecords)#</h2>");
    writeOutput("<h2>Invalid Records: #arrayLen(invalidRecords)#</h2>");
    
    // Step 3: Transform Fields
    if (arrayLen(validRecords) gt 0) {
        transformedRecord = validRecords[1];
        transformedRecord["age_numeric"] = processor.transformField(validRecords[1]["age"], "number");
        writeOutput("<h2>Transformed First Record:</h2><pre>#serializeJSON(transformedRecord, true)#</pre>");
    }
</cfscript>
