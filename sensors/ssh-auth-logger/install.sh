#!/bin/bash
read -p "Enter CHN Server IP:" chn_ip
read -p "Deploy Secret:" deploy_secret
sudo wget "https://$chn_ip/api/script/?text=true&script_id=8" --no-check-certificate -O deploy.sh && sudo bash deploy.sh https://$chn_ip $deploy_secret && sudo docker-compose up -d
