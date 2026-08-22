# MillScript Cryptographic Engine

This tool implements the **AES-256** (Advanced Encryption Standard) algorithm in MillScript. It provides a complete suite for:

- **Encryption**: Encrypts plaintext strings using a 256-bit key and random IV.
- **Decryption**: Decrypts AES-encrypted ciphertext back to plaintext.
- **Key Generation**: Generates secure, high-entropy cryptographic keys.
- **Key Derivation**: Derives keys from passwords using a secure hashing process.

The implementation includes the full AES round transformations: SubBytes, ShiftRows, MixColumns, and AddRoundKey.

## How to Use

1. **Generate a Key**: `generateKey()` or `deriveKey("password")`
2. **Encrypt**: `aesEncrypt("plaintext", "key_hex")`
3. **Decrypt**: `aesDecrypt("ciphertext_hex", "key_hex")`

## Example

```millscript
var key = generateKey(256)
var enc = aesEncrypt("Secret Data", key)
var dec = aesDecrypt(enc, key)
print(dec)
```
