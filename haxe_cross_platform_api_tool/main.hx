import haxe.Json;
import haxe.Http;
import sys.io.File;
import sys.io.Process;
import haxe.Serializer;
import haxe.Unserializer;
import haxe.Json;

typedef ApiConfig = {
    baseUrl: String,
    timeout: Int,
    headers: Map<String, String>
};

typedef ApiResponse = {
    status: Int,
    data: Dynamic,
    error: String
};

class CrossPlatformApiClient {
    private var config: ApiConfig;
    public function new(config: ApiConfig) {
        this.config = config;
    }

    public function get(endpoint: String, params: Map<String, String>): Future<ApiResponse> {
        var url = config.baseUrl + "/" + endpoint;
        var queryString = ";".join([for (k in params.keys()) k + "=" + params.get(k)].sort(function(a, b) return StringTools.compare(a, b)));
        if (queryString.length > 0) {
            url += "?" + queryString;
        }
        return new CrossPlatformApiClientRequest(url, "GET", config.timeout, config.headers).execute();
    }

    public function post(endpoint: String, data: Dynamic): Future<ApiResponse> {
        var url = config.baseUrl + "/" + endpoint;
        var headers = config.headers.copy();
        headers.set("Content-Type", "application/json");
        return new CrossPlatformApiClientRequest(url, "POST", config.timeout, headers).setData(Json.stringify(data)).execute();
    }

    public function put(endpoint: String, data: Dynamic): Future<ApiResponse> {
        var url = config.baseUrl + "/" + endpoint;
        var headers = config.headers.copy();
        headers.set("Content-Type", "application/json");
        return new CrossPlatformApiClientRequest(url, "PUT", config.timeout, headers).setData(Json.stringify(data)).execute();
    }

    public function delete(endpoint: String): Future<ApiResponse> {
        var url = config.baseUrl + "/" + endpoint;
        return new CrossPlatformApiClientRequest(url, "DELETE", config.timeout, config.headers).execute();
    }

    public function serialize(data: Dynamic): String {
        return Serializer.run(data);
    }

    public function deserialize(data: String): Dynamic {
        return Unserializer.run(data);
    }
}

class CrossPlatformApiClientRequest {
    private var url: String;
    private var method: String;
    private var timeout: Int;
    private var headers: Map<String, String>;
    private var data: String;

    public function new(url: String, method: String, timeout: Int, headers: Map<String, String>) {
        this.url = url;
        this.method = method;
        this.timeout = timeout;
        this.headers = headers;
        this.data = null;
    }

    public function setData(data: String): CrossPlatformApiClientRequest {
        this.data = data;
        return this;
    }

    public function execute(): Future<ApiResponse> {
        return new Future(function(cb) {
            var http = new Http(url);
            http.setHeader("User-Agent", "HaxeCrossPlatformApiClient/1.0");
            for (h in headers.keys()) {
                http.setHeader(h, headers.get(h));
            }
            http.onData = function(d) {
                var response: ApiResponse = {
                    status: http.status,
                    data: null,
                    error: ""
                };
                try {
                    response.data = Json.parse(d);
                } catch (e: Dynamic) {
                    response.data = d;
                }
                cb(response);
            };
            http.onError = function(e) {
                cb({
                    status: 0,
                    data: null,
                    error: e
                });
            };
            if (data != null) {
                http.addData = data;
            }
            http.request(false);
        });
    }
}

enum Future<T> {
    Pending;
    Success(val: T);
    Error(err: Dynamic);
}

@:forward(map, push, pop, forEach, iterator)
abstract FutureMap<T>(Array<Future<T>>) from Array<Future<T>> to Array<Future<T>> {
    public function new() {
        this = [];
    }
    public function push(future: Future<T>): Int {
        this.push(future);
        return this.length;
    }
    public function pop(): Null<Future<T>> {
        if (this.length > 0) {
            return this.pop();
        }
        return null;
    }
    public function forEach(f: Future<T> -> Void) {
        for (i in 0...this.length) {
            f(this[i]);
        }
    }
    public function iterator(): ArrayIterator<Future<T>> {
        return this.iterator();
    }
}

function main() {
    var config = {
        baseUrl: "https://api.example.com",
        timeout: 5000,
        headers: {"Authorization": "Bearer token123"}
    };
    var client = new CrossPlatformApiClient(config);
    
    var params = {page: "1", limit: "10"};
    var response = client.get("users", params);
    // In a real async environment, you'd handle the Future properly.
    // For demo purposes, we just show the structure.
    trace("API Client initialized.");
    
    var serialized = client.serialize({name: "test", value: 42});
    trace("Serialized: " + serialized);
    var deserialized = client.deserialize(serialized);
    trace("Deserialized: " + deserialized);
}
