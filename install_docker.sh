#!/usr/bin/env bash
#
# Script to install Docker Engine and Docker Compose on Ubuntu 24.01
#
# Usage: 
#   1. Make the script executable: chmod +x install_docker.sh
#   2. Run the script: sudo ./install_docker.sh

set -e

echo "========================================================"
echo "Installing Docker Engine and Docker Compose on Ubuntu..."
echo "========================================================"

# 1. Uninstall old versions if any
echo "Removing old Docker versions if present..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# 2. Update apt package index
echo "Updating apt package index..."
sudo apt-get update -y

# 3. Install packages to allow apt to use a repository over HTTPS
echo "Installing prerequisites (ca-certificates, curl, gnupg)..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg

# 4. Add Docker’s official GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
    | sudo gpg --dearmor --batch --yes -o /etc/apt/keyrings/docker.gpg

# 5. Set up the Docker repository
echo "Setting up Docker apt repository..."
# For future or not-yet-official releases, you may need to use the nearest LTS code name
# e.g., 'jammy' for 22.04, 'lunar' for 23.04, etc.
UBUNTU_CODENAME=$(lsb_release -cs 2>/dev/null || echo "focal")
echo "Detected codename: $UBUNTU_CODENAME"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $UBUNTU_CODENAME \
  stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 6. Update apt package index again with the new repository
echo "Updating apt package index with Docker repository..."
sudo apt-get update -y

# 7. Install Docker Engine, CLI, Containerd, and Docker Compose plugin
echo "Installing Docker Engine, CLI, Containerd, and Docker Compose plugin..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 8. Verify Docker installation
echo "Verifying Docker installation..."
sudo docker run hello-world

sudo usermod -aG docker $USER

echo "========================================================"
echo "Docker and Docker Compose have been successfully installed!"
echo "========================================================"

