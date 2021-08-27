#!/bin/bash

set -x

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get --yes upgrade
apt-get --yes install apt-transport-https

echo "export EDITOR=vim" >> /home/vagrant/.bashrc

# Install make
apt-get install -y make

# install requirements for ruby
snap install ruby --channel=2.6/stable --classic
su vagrant -c 'gem install bundler:2.1.4'
apt install -y gcc g++

# install chef
curl -L https://www.opscode.com/chef/install.sh | sudo bash

# accepts licenses
chef-solo --chef-license=accept || true
su vagrant -c 'chef-solo --chef-license=accept' || true

# install chef-workstation
curl https://packages.chef.io/files/stable/chef-workstation/21.2.278/ubuntu/20.04/chef-workstation_21.2.278-1_amd64.deb \
    -o chef-workstation_21.2.278-1_amd64.deb \
    && dpkg --install chef-workstation_21.2.278-1_amd64.deb \
    && rm chef-workstation_21.2.278-1_amd64.deb
