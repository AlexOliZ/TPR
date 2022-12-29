BASE_DOMAIN=$DEV_DOMAIN
FILE_NAME="ssl-cert"
PASSPHRASE="password"

# https://myproject.local/


# https://www.suse.com/support/kb/doc/?id=000018152

#openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE
#openssl rsa -in key.pem -out nopassword.key

#cat nopassword.key > server.pem
#cat cert.crt >> server.pem

#cat intermediate.crt >> server.pem


# https://learn.microsoft.com/en-us/azure/iot-hub/tutorial-x509-self-sign#step-4---self-sign-certificate-1

# openssl genpkey -out device1.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048

# openssl req -new -key device1.key -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE -out device1.csr

# openssl req -text -in device1.csr -noout

# openssl x509 -req -days 365 -in device1.csr -signkey device1.key -out device1.crt

# openssl genpkey -out device2.key -algorithm RSA -pkeyopt rsa_keygen_bits:2048

# openssl req -new -key device2.key -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE -out device2.csr

# openssl x509 -req -days 365 -in device2.csr -signkey device2.key  -out device2.crt

# openssl x509 -in device1.crt -noout -fingerprint

# openssl x509 -in device2.crt -noout -fingerprint

# https://www.baeldung.com/openssl-self-signed-cert

# openssl genrsa -aes256 -out domain.key -passout pass:$PASSPHRASE 2048

# openssl req -key domain.key -new -out domain.csr -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE

# openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt -passin pass:$PASSPHRASE

# openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -out rootCA.crt -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE -passout pass:$PASSPHRASE

# openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in domain.csr -out domain.crt -days 365 -CAcreateserial -extfile config.ext -passin pass:$PASSPHRASE



#   Generate private RSA
openssl genrsa -aes256 -out ca-key.pem -passout pass:$PASSPHRASE 4096 
#   Generate a public CA Cert
openssl req -new -x509 -sha256 -days 365 -key ca-key.pem -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE -out ca.pem
#   Create a RSA key
openssl genrsa -out cert-key.pem 4096
#   Create a Certificate Signing Request (CSR)
openssl req -new -sha256 -subj "/CN=$BASE_DOMAIN" -key cert-key.pem -out cert.csr -keyout "$FILE_NAME.key"
#openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial

#echo "subjectAltName=DNS:*.local,IP:127.0.0.1" >> extfile.cnf

#   Create the Certificate
openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -CAcreateserial -extfile config.ext -passin pass:$PASSPHRASE #-extfile extfile.cnf
# chmod 400 "$FILE_NAME.key"
cat cert.pem > fullchain.pem 
cat ca.pem >> fullchain.pem