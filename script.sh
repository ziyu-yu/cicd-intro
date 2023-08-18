#! /bin/bash
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done
sudo systemctl start docker
sudo systemctl enable docker
sudo groupadd docker
sudo usermod -aG docker jenkins
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

cd /home/ubuntu/
echo "ECR_REPOSITORY=$ECR_REPOSITORY 
CONTAINER_NAME=$CONTAINER_NAME" >> .env

sudo docker image  prune -f
sudo docker-compose --env-file=.env pull && docker-compose --env-file=.env up -d