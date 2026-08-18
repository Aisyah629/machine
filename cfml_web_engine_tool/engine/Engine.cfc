<cfcomponent output="false">
    <cfscript>
        /**
         * Core Web Engine Component
         * Orchestrates routing, parsing, sessions, DB, and hooks.
         */
        properties = {};
        settings = {};
        running = false;
        
        public function init(required struct settings) {
            settings = arguments.settings;
            properties.router = createObject("engine.Router");
            properties.parser = createObject("engine.Parser");
            properties.sessionMgr = createObject("sessions.SessionManager");
            properties.dbConn = createObject("db.DBConnector");
            properties.hooks = createObject("hooks.HookRegistry");
            return this;
        }
        
        public function setRouter(required any router) { properties.router = router; }
        public function setParser(required any parser) { properties.parser = parser; }
        public function setSessionManager(required any sessionMgr) { properties.sessionMgr = sessionMgr; }
        public function setDatabaseConnector(required any dbConn) { properties.dbConn = dbConn; }
        public function setHookRegistry(required any hooks) { properties.hooks = hooks; }
        
        public function start() {
            if (running) return this;
            
            // Validate configuration
            if (!structKeyExists(settings, "server") || !structKeyExists(settings.server, "port")) {
                throw(type="ConfigError", message="Missing server.port in settings");
            }
            
            running = true;
            writeOutput("Engine starting on port: " & settings.server.port);
            
            // Start listener (simulated for CFML standalone context)
            startServer();
            
            return this;
        }
        
        private function startServer() {
            // In a real deployment, this would bind to a socket or integrate with Lucee/Adobe CF application server
            // Here we simulate a non-blocking event loop structure
            writeOutput("Listening for connections...");
        }
        
        public function stop() {
            running = false;
            writeOutput("Engine stopped.");
            return this;
        }
        
        public function processRequest(any request) {
            if (!running) throw(type="RuntimeError", message="Engine is not running");
            
            // 1. Parse request
            parsed = properties.parser.parse(request);
            
            // 2. Route
            route = properties.router.match(parsed);
            
            // 3. Handle via session & DB if needed
            session = properties.sessionMgr.getSession(parsed);
            db = properties.dbConn.getConnection();
            
            // 4. Execute route logic (simplified)
            response = { status: 200, content: "Engine processing complete.", session: session, dbHandle: db };
            
            return response;
        }
    </cfscript>
</cfcomponent>
