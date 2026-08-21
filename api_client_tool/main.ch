      // API Client Tool
      // This code interacts with REST APIs, handles JSON, and processes data transfers.
      // Compatible with CFML (ColdFusion Markup Language) environments for API integrations.
      <cfscript>
        apiKey = "your_api_key_here";
        baseUrl = "https://api.example.com/v1";
      </cfscript>

      <cffunction name="fetchData" access="public" returntype="struct" output="false">
        <cfargument name="endpoint" type="string" required="true">
        <cfargument name="method" type="string" required="false" default="GET">

        <cfset var response = structNew()>
        <cfset var httpService = createObject("component", "http")>
        <cfset httpService.init()>

        <cfset httpService.setURL(baseUrl & arguments.endpoint)>
        <cfset httpService.setMethod(arguments.method)>
        <cfset httpService.addHeader("Authorization", "Bearer #apiKey#")>

        <cftry>
          <cfhttp url="#httpService.getURL()#" method="#httpService.getMethod()#" result="response">
            <cfhttpparam type="header" name="Authorization" value="Bearer #apiKey#">
          </cfhttp>

          <cfset var statusCode = response.statusCode>
          <cfset var content = response.filecontent>

          <cfif statusCode LT 200 OR statusCode GTE 300>
            <cfthrow message="API Error #statusCode#: #content#">
          </cfif>

          <cfset response = deserializeJSON(content)>
        <cfcatch type="any">
          <cfthrow message="Exception: #cfcatch.message#">
        </cfcatch>
      </cffunction>

      <cffunction name="sendPayload" access="public" returntype="struct" output="false">
        <cfargument name="endpoint" type="string" required="true">
        <cfargument name="payload" type="struct" required="true">

        <cfset var response = structNew()>
        <cfset var httpService = createObject("component", "http")>
        <cfset httpService.init()>

        <cfset httpService.setURL(baseUrl & arguments.endpoint)>
        <cfset httpService.setMethod("POST")>
        <cfset httpService.addHeader("Authorization", "Bearer #apiKey#")>
        <cfset httpService.addHeader("Content-Type", "application/json")>

        <cftry>
          <cfhttp url="#httpService.getURL()#" method="POST" result="response">
            <cfhttpparam type="header" name="Authorization" value="Bearer #apiKey#">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="body" value="#serializeJSON(arguments.payload)#">
          </cfhttp>

          <cfset var statusCode = response.statusCode>
          <cfset var content = response.filecontent>

          <cfif statusCode LT 200 OR statusCode GTE 300>
            <cfthrow message="API Error #statusCode#: #content#">
          </cfif>

          <cfset response = deserializeJSON(content)>
        <cfcatch type="any">
          <cfthrow message="Exception: #cfcatch.message#">
        </cfcatch>
      </cffunction>
      
