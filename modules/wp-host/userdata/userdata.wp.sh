#!/bin/bash

apt-get update &&
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    auditd \
    jq \
    gnupg-agent \
    software-properties-common \
    awscli &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - &&
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" &&
 
apt-get update &&
apt-get install -y docker-ce docker-ce-cli containerd.io

systemctl enable docker && systemctl restart docker &&
usermod -a -G docker ubuntu

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

docker network create proxy

### update Hostname
hostnamectl set-hostname wp-host

###

cd /home/ubuntu

touch /home/ubuntu/.ssh/known_hosts
chown ubuntu: /home/ubuntu/.ssh/known_hosts
chmod 600 /home/ubuntu/.ssh/known_hosts

mkdir wp
chown -R ubuntu: wp

cd wp

cat > traefik.yaml << EOF
${TRAEFIK_CONFIG}
EOF

cat > uploads.ini << EOF
${UPLOADS_INI}
EOF

# TODO: wp no longer creates this at install - should we write one? ok without?
chown www-data:www-data .htaccess

cat traefik.yaml

mkdir certs

cat > certs/server.crt << EOF
${TLS_CRT}
EOF

cat > certs/server.key << EOF
${TLS_KEY}
EOF

cat > docker-compose.yml << EOF
version: '3.7'
services:
  wordpress:
    image: wordpress:latest
    deploy:
      resources:
        limits:
          cpus: 1.00
          memory: 768M
        reservations:
          memory: 512M
    restart: always
    networks:
      - proxy
    ports:
      - "80:80"
      - "443:443"
    labels:
      - traefik.enable=true
      - traefik.http.routers.playground.rule=Host(\`${SUBDOMAIN}.${ZONE_NAME}\`,\`${ZONE_NAME}\`)
      - traefik.http.services.playground.loadbalancer.server.port=80
      - traefik.http.routers.playground.tls=true
    environment:
      WORDPRESS_DB_HOST: ${DB_HOST}
      WORDPRESS_DB_USER: ${DB_USER}
      WORDPRESS_DB_PASSWORD: "${DB_PWD}"
      WORDPRESS_DB_NAME: ${DB_NAME}
      WORDPRESS_CONFIG_EXTRA: >
        define( 'MAILERSEND_SMTP_PASSWORD', '${MAILERSEND_SMTP_PASSWORD}' );
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini
      - ./wp-content:/var/www/html/wp-content

networks:
  proxy:
    external:
      name: proxy
EOF

mkdir wp-content

docker-compose up -d
