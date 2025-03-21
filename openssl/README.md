SSL (Secure Socket Layer):

```
OpenSSL library on Linux to generate a self-signed certificate (.crt) and a certificate signing request (.csr)

How to install and check version of openssl?
sudo yum update -y
sudo yum install openssl
openssl --version
OpenSSL 3.4.0 22 Oct 2024 (Library: OpenSSL 3.4.0 22 Oct 2024)

## Variables:
DOMAIN="Cloudbird"
echo $DOMAIN
BYTE="2048"
echo $BYTE
DAYS="365"
echo $DAYS

openssl genrsa -out "$DOMAIN.key" "$BYTE"
openssl rsa -in "${DOMAIN}.key" -pubout -out "${DOMAIN}_pub.key"
openssl req -new -key "$DOMAIN.key" -out "$DOMAIN.csr" -subj "/C=IN/ST=KA/L=Bangalore/O=Cloudbird/OU=Cloudbird/CN=*.${DOMAIN}.fun/emailAddress=admin@${DOMAIN}.fun"
openssl req -text -in "$DOMAIN.csr" -noout -verify | grep -i 'Certificate request self-signature ok'
openssl x509 -in "$DOMAIN.csr" -out "$DOMAIN.crt" -req -signkey "$DOMAIN.key" -days "$DAYS"

