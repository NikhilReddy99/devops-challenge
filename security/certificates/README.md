# Certificates

**Do not commit production TLS certificates or private keys to Git.**

Recommended approaches:
- Use cert-manager in Kubernetes to handle ACME / Let's Encrypt.
- Use HashiCorp Vault or a cloud provider secret manager for private keys.
- For local development, generate self-signed certificates and keep them out of the repo (gitignored).

Example (self-signed dev cert):
```
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout dev.key -out dev.crt -subj "/CN=localhost"
```
