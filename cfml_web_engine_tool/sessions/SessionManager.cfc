<cfcomponent output="false">
    <cfscript>
        /**
         * Secure Session Manager
         * Supports memory, database, or distributed cache persistence.
         */
        sessions = {};
        settings = {};
        
        public function init(required struct settings) {
            settings = arguments.settings;
            return this;
        }
        
        public function getSession(any request) {
            var sessionId = request.sessionId ?: "unknown";
            
            if (!structKeyExists(sessions, sessionId)) {
                sessions[sessionId] = {
                    id: sessionId,
                    created: now(),
                    data: {},
                    timeout: settings.sessions.timeout ?: 30
                };
            }
            
            return sessions[sessionId];
        }
        
        public function destroySession(required string sessionId) {
            if (structKeyExists(sessions, sessionId)) {
                structDelete(sessions, sessionId);
                return true;
            }
            return false;
        }
        
        public function regenerateSession(any oldSession) {
            var newId = createUUID();
            var newSession = oldSession;
            newSession.id = newId;
            newSession.created = now();
            newSession.data = {};
            
            sessions[newId] = newSession;
            return newSession;
        }
    </cfscript>
</cfcomponent>
