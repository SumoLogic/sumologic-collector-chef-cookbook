# frozen_string_literal: true

#
# Author:: Ben Newton (<ben@sumologic.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Configure sumo.conf for unattended installs and activation
#
# Copyright 2013, Sumo Logic
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# The template sumo.conf file includes variables to customize it (username, password, etc.)
#
# Sumo Logic Help Links
# https://service.sumologic.com/ui/help/Default.htm#Unattended_Installation_from_a_Linux_Script_using_the_Collector_Management_API.htm
# https://service.sumologic.com/ui/help/Default.htm#Deploying_a_Windows_Collector_Automatically.htm
# https://service.sumologic.com/ui/help/Default.htm#Using_sumo.conf.htm
# https://service.sumologic.com/ui/help/Default.htm#JSON_Source_Configuration.htm

# Use the credentials variable to keep the proper credentials - regardless of source
credentials = {}

chef_gem 'chef-vault' do
  compile_time true if respond_to?(:compile_time)
  version node['sumologic']['chef_vault_version'] unless node['sumologic']['chef_vault_version'].nil?
end

require 'chef-vault'

if node['sumologic']['credentials']
  creds = node['sumologic']['credentials']

  if creds[:secret_file]
    secret = Chef::EncryptedDataBagItem.load_secret(creds[:secret_file]) # ~FC086
    item = Chef::EncryptedDataBagItem.load(creds[:bag_name], creds[:item_name], secret) # ~FC086
  else
    item = if ChefVault::Item.vault?(creds[:bag_name], creds[:item_name])
             ChefVault::Item.load(creds[:bag_name], creds[:item_name])
           else
             data_bag_item(creds[:bag_name], creds[:item_name])
           end
  end

  %i[accessID accessKey].each do |sym|
    credentials[sym] = item[sym.to_s] # Chef::DataBagItem 10.28 doesn't work with symbols
  end

else
  %i[accessID accessKey].each do |sym|
    credentials[sym] = node['sumologic'][sym]
  end
end

# Check to see if the default sumo.conf was overridden
conf_source = node['sumologic']['conf_template'] || 'sumo.conf.erb'

# Create the conf file's parent directory (generally for Windows support)
directory ::File.dirname(node['sumologic']['sumo_conf_path']) do
  recursive true
end

template node['sumologic']['sumo_conf_path'] do
  cookbook node['sumologic']['conf_config_cookbook']
  source conf_source
  sensitive true
  unless platform?('windows')
    owner 'root'
    group 'root'
    mode '0600'
  end

  # this may look strange, but one pair will be nil, so it all works out
  variables(accessID: credentials[:accessID],
            accessKey: credentials[:accessKey])
end
