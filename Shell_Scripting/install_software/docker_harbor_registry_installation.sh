#Run this script with after switching to sudo ie: sudo su


#!/bin/bash

set -e

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker not found → installing…"
  curl -fsSL https://get.docker.com -o get-docker.sh
  bash get-docker.sh
  usermod -aG docker vagrant
  rm -f get-docker.sh
fi

#Change with the version you want to install
HARBOR_VERSION="v2.13.1"
HARBOR_FILE="harbor-offline-installer-$HARBOR_VERSION.tgz"

if [ -f "$HARBOR_FILE" ]; then
  echo "$HARBOR_FILE already exists, skipping download..."
else
  echo "Downloading $HARBOR_FILE..."
  wget https://github.com/goharbor/harbor/releases/download/$HARBOR_VERSION/$HARBOR_FILE
fi

 

#Download the offline installer : Go to the link and pste here latest link


tar xzvf harbor-offline-installer-v2.13.1.tgz

#Certification (https://goharbor.io/docs/2.13.0/install-config/configure-https/)
cd /opt

openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -sha512 -days 3650 \
-subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" \
-key ca.key \
-out ca.crt

openssl genrsa -out harbor.registry.local.key 4096 #Here 4096 is it's size

openssl req -sha512 -new \
-subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" \
-key harbor.registry.local.key -out \
harbor.registry.local.csr


cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=harbor.registry.local
DNS.2=harbor.registry
DNS.3=harbor.registry.local
EOF


openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CA ca.crt -CAkey ca.key -CAcreateserial -in harbor.registry.local.csr -out harbor.registry.local.crt

mkdir -p /data/cert/

cp harbor.registry.local.crt /data/cert/
cp harbor.registry.local.key /data/cert/
cp ca.crt /data/cert/

cd /data/cert/
openssl x509 -inform PEM -in harbor.registry.local.crt -out harbor.registry.local.cert


mkdir -p /etc/docker/certs.d/harbor.registry.local/


cp harbor.registry.local.cert /etc/docker/certs.d/harbor.registry.local/
cp harbor.registry.local.key /etc/docker/certs.d/harbor.registry.local/
cp ca.crt /etc/docker/certs.d/harbor.registry.local/

systemctl restart docker

#Deploy Harbor

cd /home/vagrant/harbor

cp harbor.yml.tmpl harbor.yml
sed -i 's/hostname: reg.mydomain.com/hostname: harbor.registry.local/' harbor.yml
sed -i 's|certificate: /your/certificate/path|certificate: /data/cert/harbor.registry.local.crt|' harbor.yml
sed -i 's|private_key: /your/private/key/path|private_key: /data/cert/harbor.registry.local.key|' harbor.yml

./install.sh --with-trivy

echo "All process are completed successfully"

echo "https://harbor.registry.local/"

echo "Username: admin
      Password: Harbor12345"
