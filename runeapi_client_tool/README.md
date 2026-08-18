RuneAPI Client Tool
===================

A robust data transfer and API interaction script written in a high-level functional language.

Features
--------
- Asynchronous HTTP client with connection pooling.
- Automatic JSON serialization and deserialization.
- Built-in retry logic with exponential backoff for transient network errors.
- Secure header handling.
- Comprehensive logging for debugging API interactions.

Usage
-----
1. Define the API endpoint and authentication credentials.
2. Call the `makeRequest` function with the appropriate parameters.
3. Handle the returned response object.

Example
-------
```js
let response = await apiClient.request('POST', '/v1/users', {name: 'Rune'});
if (response.status === 200) {
    print(response.body);
} else {
    print('Error: ' + response.status);
}
```
