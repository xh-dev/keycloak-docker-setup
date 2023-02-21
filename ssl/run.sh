#!/bin/bash

pushd certs
# https://docs.cpanel.net/knowledge-base/security/how-to-configure-mysql-ssl-connections/

CA_BASE_DOMAIN="example.com"
CA_ROOT_CN=root.$CA_BASE_DOMAIN
CA_CLIENT_CN=client.$CA_BASE_DOMAIN
SERVER_KC=kc
CA_O=DEXTRO_LINK
CA_OU=IT
CA_LOCALITY=HK
CA_STATE=HK
CA_COUNTRY=HK

genServerCert(){
    SERVER_NAME=$1
    CA_SERVER_CN=$SERVER_NAME.$CA_BASE_DOMAIN
    mkdir $SERVER_NAME
    pushd $SERVER_NAME

    ehco "General certificates for $CA_SERVER_CN"
    SERIAL=$2

    openssl req -sha256 -newkey rsa:$CUST_KEY_SIZE -days 3650 -nodes -subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCALITY/O=$CA_O/OU=$CA_OU/CN=$CA_SERVER_CN" -keyout server-$SERVER_NAME-key.pem > server-$SERVER_NAME-req.pem
    openssl x509 -sha256 -req -in server-$SERVER_NAME-req.pem -days 3650  -extfile <(printf "subjectAltName=DNS:$CA_SERVER_CN,DNS:localhost") -CA ../ca-cert.pem -CAkey ../ca-key.pem -set_serial $SERIAL > server-$SERVER_NAME-cert.pem
    cat ../ca-cert server-$SERVER_NAME-cert.pem > bundle.pem

    popd
}


CUST_KEY_SIZE=4096

openssl genrsa $CUST_KEY_SIZE > ./ca-key.pem
openssl req -sha256 -new -x509 -nodes -subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCALITY/O=$CA_O/OU=$CA_OU/CN=$CA_ROOT_CN" -days 3650 -key ca-key.pem > ca-cert.pem

genServerCert $SERVER_KC 10

openssl req -sha256 -newkey rsa:$CUST_KEY_SIZE -days 3650 -nodes -subj "/C=$CA_COUNTRY/ST=$CA_STATE/L=$CA_LOCALITY/O=$CA_O/OU=$CA_OU/CN=$CA_CLIENT_CN" -keyout client-key.pem > client-req.pem
openssl x509 -sha256 -req -in client-req.pem -days 3650 -CA ca-cert.pem -CAkey ca-key.pem -set_serial 11 > client-cert.pem
openssl rsa -in client-key.pem -out client-key.pem

chmod 0644 *.pem
popd
