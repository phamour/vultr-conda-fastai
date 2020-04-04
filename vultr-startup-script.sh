#!/bin/sh

# Install system dependencies
apt update -y
apt install bzip2 libsm6 libxext6 libxrender-dev

# Install Anaconda3 in silent mode
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O /tmp/anaconda3.sh
bash /tmp/anaconda3.sh -b -p /opt/anaconda3

# Setup PATH
cp /etc/profile /etc/profile.bak.0
echo 'export PATH=/opt/anaconda3/bin:$PATH' | sudo tee -a /etc/profile
source /etc/profile

# Conda init
conda init bash

# Setup fastai
git clone https://github.com/fastai/fastai.git ~/fastai
cd ~/fastai
conda env create -f environment-cpu.yml
conda activate fastai-cpu

# Start Jupyter Notebook server
jupyter notebook --allow-root > ~/jn.log 2>&1 &
