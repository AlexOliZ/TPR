BASE_DOMAIN=$DEV_DOMAIN
FILE_NAME="ssl-cert"
PASSPHRASE="password"

# https://myproject.local/

# openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem
# openssl rsa -in server.key -out nopassword.key

# cat nopassword.key > server.pem
# cat server.crt >> server.pem


# cat intermediate.crt >> server.pem

#   Generate private RSA
openssl genrsa -aes256 -out ca-key.pem -passout pass:$PASSPHRASE 4096 
#   Generate a public CA Cert
openssl req -new -x509 -sha256 -days 365 -key ca-key.pem -subj "/C=PT/ST=AVEIRO/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE -out ca.pem
#   Create a RSA key
openssl genrsa -out cert-key.pem 4096
#   Create a Certificate Signing Request (CSR)
openssl req -new -sha256 -subj "/CN=$BASE_DOMAIN" -key cert-key.pem -out cert.csr -keyout "$FILE_NAME.key"
#openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -extfile extfile.cnf -CAcreateserial

echo "subjectAltName=DNS:*$BASE_DOMAIN,IP:127.0.0.1" >> extfile.cnf

#   Create the Certificate
openssl x509 -req -sha256 -days 365 -in cert.csr -CA ca.pem -CAkey ca-key.pem -out cert.pem -CAcreateserial -extfile config.ext -passin pass:$PASSPHRASE #-extfile extfile.cnf
# chmod 400 "$FILE_NAME.key"
cat cert.pem > fullchain.pem 
cat ca.pem >> fullchain.pem
















#openssl dhparam -out /etc/nginx/dhparam.pem 4096

#openssl genrsa -out client.key 4096
#openssl req -new -x509 -text -key client.key -out client.cert


#openssl req -text -in cert.csr -noout -verify

# #!/usr/bin/env bash

# # Set the TLD domain we want to use
# BASE_DOMAIN=$DEV_DOMAIN

# # Days for the cert to live
#DAYS=1095

# # A blank passphrase
# PASSPHRASE="password"

# # Generated configuration file
# CONFIG_FILE="config.txt"

# cat > $CONFIG_FILE <<-EOF
# [req]
# default_bits = 2048
# prompt = no
# default_md = sha256
# x509_extensions = v3_req
# distinguished_name = dn
# [dn]
# C = CA
# ST = BC
# L = Vancouver
# O = Example Corp
# OU = Testing Domain
# emailAddress = webmaster@$BASE_DOMAIN
# CN = $BASE_DOMAIN
# [v3_req]
# subjectAltName = @alt_names
# [alt_names]
# DNS.1 = *.$BASE_DOMAIN
# DNS.2 = $BASE_DOMAIN
# EOF

# # The file name can be anything
# FILE_NAME="ssl-cert"

# # Remove previous keys
# echo "Removing existing certs like $FILE_NAME.*"
# chmod 770 $FILE_NAME.*
# rm $FILE_NAME.*

# echo "Generating certs for $BASE_DOMAIN"

# # Generate our Private Key, CSR and Certificate
# # Use SHA-2 as SHA-1 is unsupported from Jan 1, 2017

#openssl req -new -x509 -newkey rsa:2048 -sha256 -nodes -keyout "$FILE_NAME.key" -days $DAYS -out "$FILE_NAME.crt" -passin pass:$PASSPHRASE -subj "/C=UK/ST=Warwickshire/L=Leamington/O=OrgName/OU=IT Department/CN=$BASE_DOMAIN" -passin pass:$PASSPHRASE

# # OPTIONAL - write an info to see the details of the generated crt
#openssl x509 -noout -fingerprint -text < "$FILE_NAME.crt" > "$FILE_NAME.info"

# # Protect the key
# chmod 400 "$FILE_NAME.key"