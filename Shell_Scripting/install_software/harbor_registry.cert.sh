#Run this script with after switching to sudo ie: sudo su

#!/bin/bash

#To download docker if not available dimply uncomment below 2 lines

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
 

#Download the offline installer : Go to the link and pste here latest link

wget https://github.com/goharbor/harbor/releases/download/v2.13.1/harbor-offline-installer-v2.13.1.tgz

#Extract the copied link

tar xzvf harbor-offline-installer-v2.13.1.tgz

#For certificate generation

cd /opt

#Generate a Certificate Authority Certificate
#Generate a CA certificate private key.
openssl genrsa -out ca.key 4096

#Generate the CA certificate.
openssl req -x509 -new -nodes -sha512 -days 3650 \
-subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" \
-key ca.key \
-out ca.crt

#Generate a Server Certificate
#Generate a private key.
openssl genrsa -out harbor.registry.local.key 4096 #Here 4096 is it's size

#Generate a certificate signing request (CSR).
openssl req -sha512 -new \
-subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" \
-key harbor.registry.local.key -out \
harbor.registry.local.csr

#Generate an x509 v3 extension file.
cat > v3.ext <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment,
dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1=harbor.registry.local
DNS.2=harbor.registry
DNS.3=harbor.registry.local
EOF

#Use the v3.ext file to generate a certificate for your Harbor host
openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CA ca.crt -CAkey ca.key \
-CAcreateserial -in harbor.registry.local.csr \
-out harbor.registry.local.crt

#Provide the Certificates to Harbor and Docker
#Create directory cert in harbor host.
mkdir -p /data/cert/

#Copy the server certificate and key into the cert folder on your Harbor host.

cp harbor.registry.local.crt /data/cert/
cp harbor.registry.local.key /data/cert/

#Convert yourdomain.com.crt to yourdomain.com.cert, for use by Docker.
openssl x509 -inform PEM -in harbor.registry.local.crt -out harbor.registry.local.cert

#Create certs.d directory and the registry directory.
mkdir -p /etc/docker/certs.d/harbor.registry.local/

#Copy the server certificate, key and CA files into the Docker certificates folder on the Harbor host.

cp harbor.registry.local.cert /etc/docker/certs.d/harbor.registry.local/
cp harbor.registry.local.key /etc/docker/certs.d/harbor.registry.local/
cp ca.crt /etc/docker/certs.d/harbor.registry.local/

#Restart Docker Engine.
systemctl restart docker

systemctl status docker


#Deploy Harbor
#Change into the directory where the harbor binary is extracted.
cd /home/vagrant/harbor

#Copy harbor.yml.tmpl to harbor.yml
cp harbor.yml.tmpl harbor.yml
sed -i 's/hostname: reg.mydomain.com/hostname: harbor.registry.local/' harbor.yml
sed -i 's|certificate: /your/certificate/path|certificate: /data/cert/harbor.registry.local.crt|' harbor.yml
sed -i 's|private_key: /your/private/key/path|private_key: /data/cert/harbor.registry.local.key|' harbor.yml

./install.sh --with-trivy

echo "All process are completed successfully"

echo "https://harbor.registry.local/"

echo "Username: admin
      Password: Harbor12345"
