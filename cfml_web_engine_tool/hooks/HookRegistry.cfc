<cfcomponent output="false">
    <cfscript>
        /**
         * Request/Response Lifecycle Hook Manager
         * Allows plugin-like pre/post processing.
         */
        hooks = {};
        
        public function init() {
            return this;
        }
        
        public function register(required string name, required any callback) {
            if (!structKeyExists(hooks, name)) {
                hooks[name] = [];
            }
            hooks[name].append(callback);
            return this;
        }
        
        public function fire(required string name, required any arg1, any arg2 = null) {
            var current = arg1;
            
            if (structKeyExists(hooks, name)) {
                for (cb in hooks[name]) {
                    if (isNull(arg2)) {
                        current = cb(current);
                    } else {
                        current = cb(current, arg2);
                    }
                }
            }
            
            return current;
        }
        
        public function remove(required string name, required any callback) {
            if (structKeyExists(hooks, name)) {
                for (i = 1; i lte arrayLen(hooks[name]); i++) {
                    if (hooks[name][i] == callback) {
                        arrayDeleteAt(hooks[name], i);
                        break;
                    }
                }
            }
            return this;
        }
    </cfscript>
</cfcomponent>
