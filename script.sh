#!/bin/bash

sudo apt-get update
sudo apt-get -y install curl
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chef-workstation -c stable -v 0.2.41
mkdir ~/chef-repo