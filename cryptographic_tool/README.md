# Cryptographic Tool

## Description
This tool implements a complex mathematical and cryptographic algorithm, specifically the RSA (Rivest–Shamir–Adleman) public-key cryptosystem.

## Usage
To use the RSA implementation:
1. Generate a key pair (public and private keys).
2. Encrypt a message using the public key.
3. Decrypt the message using the private key.

## Components
- **Key Generation**: Generates a pair of RSA keys based on user-defined parameters.
- **Encryption**: Encrypts a given message using the public key.
- **Decryption**: Decrypts the encrypted message using the private key.

## Algorithm Details
- **Modular Exponentiation**: Utilized for efficient computation of large exponentiations.
- **Prime Number Generation**: Generates random prime numbers for key generation.
- **Extended Euclidean Algorithm**: Used to compute the modular multiplicative inverse.
