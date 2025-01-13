#/bin/bash
sudo apt-get update -y
sudo apt install python3 -y
sudo mkdir -p /opt && sudo git clone https://github.com/CommunityHoneyNetwork/chn-quickstart.git /opt/chnserver
cd /opt/chnserver
sudo apt install python3-validators -y
sudo ./guided_docker_compose.py
docker compose up -d
