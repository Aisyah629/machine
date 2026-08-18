<cfcomponent output="false">
    <cfscript>
        /**
         * Configuration-Driven Routing Engine
         * Pattern matching, middleware support, and fallback handling.
         */
        routes = [];
        middleware = [];
        fallbackHandler = null;
        
        public function init() {
            return this;
        }
        
        public function addRoute(required string method, required string pattern, required any handler) {
            routes.append({
                method: method,
                pattern: pattern,
                handler: handler,
                middleware: middleware.dup()
            });
            return this;
        }
        
        public function use(required any middleware) {
            middleware.append(middleware);
            return this;
        }
        
        public function setFallback(required any handler) {
            fallbackHandler = handler;
            return this;
        }
        
        public function match(required any request) {
            var reqMethod = request.getMethod().upper();
            var reqPath = request.getPath();
            
            for (r in routes) {
                if (r.method == reqMethod && reFind(r.pattern, reqPath)) {
                    return {
                        matched: true,
                        route: r,
                        params: reMatch(r.pattern, reqPath)
                    };
                }
            }
            
            if (!isNull(fallbackHandler)) {
                return {
                    matched: true,
                    route: { handler: fallbackHandler },
                    params: {}
                };
            }
            
            return {
                matched: false,
                status: 404
            };
        }
    </cfscript>
</cfcomponent>
