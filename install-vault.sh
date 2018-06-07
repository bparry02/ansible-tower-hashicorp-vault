#!/bin/bash

sudo yum install -y unzip

sudo mkdir -p /opt/vault

sudo unzip vault_0.10.1_linux_amd64.zip -d /opt/vault

mkdir -p ~/bin
ln -s /opt/vault/vault ~/bin/vault
