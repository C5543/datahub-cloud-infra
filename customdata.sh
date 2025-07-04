#!/bin/bash

# === تحديث النظام وتثبيت الأدوات ===
sudo apt update
sudo apt install -y gnupg2 wget curl git docker.io docker-compose

# === إعداد Docker للمستخدم ===
usermod -aG docker azureuser
newgrp docker

# === تثبيت Miniconda ===
sudo -u azureuser mkdir -p /home/azureuser/miniconda3
sudo -u azureuser wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/azureuser/miniconda3/miniconda.sh
sudo -u azureuser bash /home/azureuser/miniconda3/miniconda.sh -b -u -p /home/azureuser/miniconda3
sudo -u azureuser rm /home/azureuser/miniconda3/miniconda.sh
echo 'export PATH="/home/azureuser/miniconda3/bin:$PATH"' | sudo -u azureuser tee -a /home/azureuser/.bashrc

# === تثبيت PostgreSQL 16 ===
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
sudo apt update
sudo apt install -y postgresql-16 postgresql-contrib-16 postgresql-client-16
sudo systemctl start postgresql
sudo systemctl enable postgresql

# === تثبيت DataHub ===
cd /home/azureuser
sudo -u azureuser git clone https://github.com/datahub-project/datahub.git
cd datahub/docker
sudo -u azureuser ./quickstart.sh
