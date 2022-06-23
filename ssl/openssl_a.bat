@D:\xampp\apache\bin\openssl.exe req -x509 -nodes -sha256 -days 3650 -subj "/CN=Local" -newkey rsa:2048 -keyout Local.key -out Local.crt
@D:\xampp\apache\bin\openssl.exe pkcs12 -export -in Local.crt -inkey Local.key -CSP "Microsoft Enhanced RSA and AES Cryptographic Provider" -out Local.pfx




set OPENSSL_CONF=D:\xampp\apache\conf\openssl.cnf
D:\xampp\apache\bin\openssl.exe genrsa -out server.key 2048
D:\xampp\apache\bin\openssl.exe req -new -key server.key -out server.csr -sha256
D:\xampp\apache\bin\openssl.exe x509 -req -days 365 -in server.csr -signkey server.key -out server.crt