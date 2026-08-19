component output="false" hint="I handle data transformation, cleaning, and validation logic.">

    <cfset variables.config = {}>
    <cfset variables.logger = createObject("component", "logger").init()>

    <cffunction name="init" access="public" returntype="data_transform_processor_tool" output="false" hint="Constructor">
        <cfreturn this>
    </cffunction>

    <cffunction name="loadConfig" access="public" returntype="void" output="false">
        <cfargument name="configPath" type="string" required="false" default="config/settings.json">
        <cftry>
            <cfset variables.config = fileRead(getConfigPath(arguments.configPath))>
            <cfcatch type="any">
                <cfset variables.config = {
                    "defaultDateFormat": "yyyy-mm-dd",
                    "defaultTimeFormat": "HH:nn:ss",
                    "loggingEnabled": true,
                    "maxRetries": 3
                }>
                <cfif variables.config.loggingEnabled>
                    <cfset variables.logger.log("ERROR", "Config file not found or invalid. Using defaults.", cfcatch.message)>
                </cfif>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="cleanData" access="public" returntype="array" output="false" hint="Cleans and normalizes an array of structures.">
        <cfargument name="data" type="array" required="true" hint="Array of structures representing records.">
        <cfset var cleanResult = []>
        <cfset var record = {}>
        <cfset var cleanedRecord = {}>
        <cfset var fieldName = "">

        <cfloop array="#arguments.data#" index="record">
            <cfset cleanedRecord = {}>
            <cfloop collection="#record#" item="fieldName">
                <cfif len(trim(fieldName)) and isStruct(record[fieldName]) or isSimpleValue(record[fieldName])>
                    <cfset cleanedRecord[fieldName] = cleanValue(record[fieldName])>
                </cfif>
            </cfloop>
            <cfif structCount(cleanedRecord) gt 0>
                <cfarrayAppend(cleanResult, cleanedRecord)>
            </cfif>
        </cfloop>

        <cfreturn cleanResult>
    </cffunction>

    <cffunction name="cleanValue" access="private" returntype="any" output="false" hint="Cleans a single value.">
        <cfargument name="value" type="any" required="true">
        <cfif isNull(arguments.value) or isEmpty(arguments.value)>
            <cfreturn "">
        <cfelseif isSimpleValue(arguments.value) and isNumeric(arguments.value)>
            <cfreturn val(arguments.value)>
        <cfelseif isSimpleValue(arguments.value) and isDate(arguments.value)>
            <cfreturn dateFormat(arguments.value, variables.config.defaultDateFormat)>
        <cfelseif isSimpleValue(arguments.value) and isArrayOf(arguments.value) or isStruct(arguments.value)>
            <!--- Return as is for nested structures or handle recursively if needed --->
            <cfreturn arguments.value>
        <cfelseif isSimpleValue(arguments.value)>
            <cfreturn trim(arguments.value)>
        <cfelse>
            <cfreturn arguments.value>
        </cfif>
    </cffunction>

    <cffunction name="validateSchema" access="public" returntype="boolean" output="false" hint="Validates a record against a schema definition.">
        <cfargument name="record" type="struct" required="true" hint="The record to validate.">
        <cfargument name="schema" type="struct" required="true" hint="Schema definition with required fields.">
        <cfset var isValid = true>
        <cfloop collection="#arguments.schema#" item="fieldName">
            <cfif not structKeyExists(arguments.record, fieldName) or isEmpty(trim(arguments.record[fieldName]))>
                <cfset isValid = false>
                <cfif variables.config.loggingEnabled>
                    <cfset variables.logger.log("WARN", "Validation Failed", "Missing field: #fieldName# in record #arguments.record.id#", "N/A")>
                </cfif>
            </cfif>
        </cfloop>
        <cfreturn isValid>
    </cffunction>

    <cffunction name="transformField" access="public" returntype="string" output="false" hint="Generic field transformer.">
        <cfargument name="value" type="any" required="true">
        <cfargument name="type" type="string" required="false" default="string" hint="Target type: string, number, date.">
        
        <cfswitch expression="#arguments.type#">
            <cfcase value="number">
                <cfreturn val(arguments.value)>
            </cfcase>
            <cfcase value="date">
                <cfif isDate(arguments.value)>
                    <cfreturn dateFormat(arguments.value, variables.config.defaultDateFormat)>
                <cfelse>
                    <cfreturn "">
                </cfif>
            </cfcase>
            <cfcase value="string">
                <cfreturn trim(arguments.value)>
            </cfcase>
            <default>
                <cfreturn arguments.value>
            </default>
        </cfswitch>
    </cffunction>

    <cffunction name="getConfigPath" access="private" returntype="string" output="false">
        <cfargument name="fileName" type="string" required="true">
        <cfscript>
            // Resolve path relative to this component
            var componentDir = getComponentMetadata(this).file;
            var dir = left(componentDir, findLast(componentDir, "/") - 1);
            return dir & "/" & arguments.fileName;
        </cfscript>
    </cffunction>

</component>
