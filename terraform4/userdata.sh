#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive

curl -fsSL https://get.docker.com | sh
systemctl enable --now docker

id ssm-user &>/dev/null || useradd -m ssm-user
usermod -aG docker ssm-user

mkdir -p /opt/rackula/data
curl -fsSL https://raw.githubusercontent.com/RackulaLives/Rackula/main/deploy/docker-compose.persist.yml \
  -o /opt/rackula/docker-compose.yml
chown -R 1001:1001 /opt/rackula/data

cd /opt/rackula
for i in $(seq 1 30); do
  if systemctl is-active --quiet docker; then break; fi
  sleep 5
done

docker compose up -d