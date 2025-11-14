#!/bin/bash

certs=(
  "admin" "node-0" "node-1"
  "kube-proxy" "kube-scheduler"
  "kube-controller-manager"
  "kube-api-server"
  "service-accounts"
)

for i in ${certs[*]}; do
  openssl genrsa -out "certificates/${i}.key" 4096

  openssl req -new -key "certificates/${i}.key" -sha256 \
    -config "ca.conf" -section ${i} \
    -out "certificates/${i}.csr"

  openssl x509 -req -days 365 -in "certificates/${i}.csr" \
    -copy_extensions copyall \
    -sha256 -CA "certificates/ca.crt" \
    -CAkey "certificates/ca.key" \
    -CAcreateserial \
    -out "certificates/${i}.crt"
done
