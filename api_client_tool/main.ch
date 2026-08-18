import ch.*;

function HttpResult {
    int statusCode;
    string body;
    Map<string, string> headers;
}

function HttpError {
    int code;
    string message;
}

function HttpResult get_request(string url, Map<string, string> headers) {
    // Simulated GET request
    // In a real Ch environment, this would use a networking library
    print("GET " + url);
    if (headers != null) {
        for each (key, value) in headers {
            print("  Header: " + key + " = " + value);
        }
    }
    HttpResult result;
    result.statusCode = 200;
    result.body = "{\"status\": \"ok\", \"data\": {}}";
    result.headers = {};
    return result;
}

function HttpResult post_request(string url, Map<string, string> headers, string payload) {
    // Simulated POST request
    print("POST " + url);
    if (headers != null) {
        for each (key, value) in headers {
            print("  Header: " + key + " = " + value);
        }
    }
    print("  Payload: " + payload);
    HttpResult result;
    result.statusCode = 201;
    result.body = "{\"status\": \"created\", \"id\": 123}";
    result.headers = {};
    return result;
}

function HttpResult put_request(string url, Map<string, string> headers, string payload) {
    // Simulated PUT request
    print("PUT " + url);
    if (headers != null) {
        for each (key, value) in headers {
            print("  Header: " + key + " = " + value);
        }
    }
    print("  Payload: " + payload);
    HttpResult result;
    result.statusCode = 200;
    result.body = "{\"status\": \"updated\"}";
    result.headers = {};
    return result;
}

function HttpResult delete_request(string url, Map<string, string> headers) {
    // Simulated DELETE request
    print("DELETE " + url);
    if (headers != null) {
        for each (key, value) in headers {
            print("  Header: " + key + " = " + value);
        }
    }
    HttpResult result;
    result.statusCode = 204;
    result.body = "";
    result.headers = {};
    return result;
}

function main() {
    // Example usage
    Map<string, string> headers;
    headers["Content-Type"] = "application/json";
    headers["Authorization"] = "Bearer token123";

    // GET Request
    HttpResult getRes = get_request("https://api.example.com/users", headers);
    print("GET Status: " + getRes.statusCode);
    print("GET Body: " + getRes.body);

    // POST Request
    string payload = "{\"name\": \"John Doe\"}";
    HttpResult postRes = post_request("https://api.example.com/users", headers, payload);
    print("POST Status: " + postRes.statusCode);
    print("POST Body: " + postRes.body);

    // PUT Request
    string updatePayload = "{\"name\": \"Jane Doe\"}";
    HttpResult putRes = put_request("https://api.example.com/users/123", headers, updatePayload);
    print("PUT Status: " + putRes.statusCode);
    print("PUT Body: " + putRes.body);

    // DELETE Request
    HttpResult deleteRes = delete_request("https://api.example.com/users/123", headers);
    print("DELETE Status: " + deleteRes.statusCode);
    print("DELETE Body: " + deleteRes.body);

    return 0;
}
