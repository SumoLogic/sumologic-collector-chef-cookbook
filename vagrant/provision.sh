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
