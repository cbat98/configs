#!/bin/sh

# Check if a Common Name (CN) is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <Common Name (e.g., example.com)>"
  exit 1
fi

# Exit on error
set -e

CN=$1
CA_DIR=~/myCA
REQ_DIR=$CA_DIR/requests
CERT_DIR=$CA_DIR/certs
KEY_DIR=$CA_DIR/private
CONFIG_FILE=$CA_DIR/openssl.cnf
DAYS_VALID=379

# Paths for the new certificate and key
KEY_FILE=$KEY_DIR/${CN}.key
CSR_FILE=$REQ_DIR/${CN}.csr
CRT_FILE=$CERT_DIR/${CN}.crt

echo "Generating a private key for $CN..."
openssl genrsa -out $KEY_FILE 2048

echo "Creating a Certificate Signing Request (CSR) for $CN..."
export CN
openssl req -config $CONFIG_FILE -new -key $KEY_FILE -out $CSR_FILE -extensions req_ext

echo "Signing the CSR with the CA to create the certificate..."
openssl ca -config $CONFIG_FILE -in $CSR_FILE -out $CRT_FILE -days $DAYS_VALID -batch -extensions usr_cert

echo "Certificate and key for $CN generated successfully."
echo "Private Key: $KEY_FILE"
echo "Certificate: $CRT_FILE"
