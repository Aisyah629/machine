# Cryptographic Tool

## Overview
This ColdFusion tool implements advanced cryptographic algorithms including RSA encryption/decryption and SHA-256 hashing. It is designed for secure data processing and verification.

## Features
- **RSA Encryption**: Encrypts plain text using a randomly generated RSA key pair.
- **RSA Decryption**: Decrypts base64 encoded strings using the corresponding private key.
- **SHA-256 Hashing**: Generates a secure hash of input strings using the SHA-256 algorithm.

## Usage

### Encrypting Data
```cfml
<cfset crypto = createObject("component", "main").init()>
<cfset encrypted = crypto.encrypt("Secret Message")>
<cfoutput>Encrypted: #encrypted#</cfoutput>
```

### Decrypting Data
```cfml
<cfset decrypted = crypto.decrypt(encrypted)>
<cfoutput>Decrypted: #decrypted#</cfoutput>
```

### Hashing Data
```cfml
<cfset hash = crypto.hash("Sensitive Data")>
<cfoutput>Hash: #hash#</cfoutput>
```

## Security Notes
- **Key Size**: The tool uses 2048-bit RSA keys for enhanced security. In production environments, always use keys of at least 2048 bits.
- **Key Management**: For production use, securely store and manage the private key. Avoid hardcoding keys in the source code.
- **Error Handling**: The tool includes basic error handling. Ensure robust error handling and logging in your applications.

## Files
- `main.cfml`: The main component containing the cryptographic functions.

## License
This tool is provided as-is for educational and development purposes.
