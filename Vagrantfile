# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-disksize")
  puts "vagrant-disksize plugin unavailable\n" \
       "please install it via 'vagrant plugin install vagrant-disksize'"
  exit 1
end

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/focal64'
  config.disksize.size = '50GB'
  config.vm.box_check_update = false
  config.vm.host_name = 'sumologic-collector-chef-cookbook'
  config.vm.network :private_network, ip: "192.168.56.46"

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = false
    vb.cpus = 8
    vb.memory = 16_384
    vb.name = 'sumologic-collector-chef-cookbook'
  end

  config.vm.provision 'shell', path: 'vagrant/provision.sh'

  config.vm.synced_folder ".", "/sumologic/sumologic-collector"
end
