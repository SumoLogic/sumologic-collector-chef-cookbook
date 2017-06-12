# frozen_string_literal: true

#
# Author:: Michael Cizmar (<michael.cizmar@mcplusa.com>)
# Cookbook Name:: windows-collector
# Recipe:: Install Sumo Logic Collector on Windows
#
#
# Copyright 2015, Sumo Logic
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

# Install Steps:
# 1. Write config from attributes
# 2. Download collector installer
# 3. Do a quiet install
#
# Quiet install looks for /etc/sumo.conf file for automated activation
#
# Sumo Logic Help Links
# https://service.sumologic.com/ui/help/Default.htm#Unattended_Installation_from_a_Linux_Script_using_the_Collector_Management_API.htm
# https://service.sumologic.com/ui/help/Default.htm#Using_sumo.conf.htm
# https://service.sumologic.com/ui/help/Default.htm#JSON_Source_Configuration.htm
#

if ::Win32::Service.exists? "sumo-collector"
  Chef::Log.info "Sumo Logic Collector found."
  Chef::Log.info "Checking for Sumo Logic Collector Updates and will "\
    "reinstall directory at #{node['sumologic']['installDir']}"

  # We only want to deploy sumo when there's a new version available
  # to preserve idempotency .
  remote_file "#{node['sumologic']['installDir']}/#{node['sumologic']['installerName']}" do
    source node['sumologic']['downloadURL']
    notifies :run, 'execute[Deploy Sumo Collector]', :immediately
  end

# If collector is already in sync source mode, just uncomment these following lines to update the sources
# include_recipe 'sumologic-collector::sumoconf'
# if node['sumologic']['use_json_path_dir'] == true
# # use the recipe sumojsondir if your source configurations are in a directory
# include_recipe 'sumologic-collector::sumojsondir'
# else
# # use the recipe sumojson if your source configurations are in a single json file
# include_recipe 'sumologic-collector::sumojson'
# end
# include_recipe 'sumologic-collector::restart'
else
  Chef::Log.info "Installing Sumo Logic Collector..."
  include_recipe 'sumologic-collector::sumoconf'
  if node['sumologic']['use_json_path_dir'] == true
    # use the recipe sumojsondir if your source configurations are in a directory
    include_recipe 'sumologic-collector::sumojsondir'
  else
    # use the recipe sumojson if your source configurations are in a single json file
    include_recipe 'sumologic-collector::sumojson'
  end

  Chef::Log.info "Installing Sumo Logic directory at #{node['sumologic']['installDir']}"

  # We only want to deploy sumo when there's a new version available
  # to preserve idempotency .
  remote_file "#{node['sumologic']['installDir']}/#{node['sumologic']['installerName']}" do
    source node['sumologic']['downloadURL']
  end

  sumologic_collector_installer node['sumologic']['installDir'] do
    source node['sumologic']['downloadURL']
  end

  # The following recipe will clean up sumo.conf and the json configuration file(s). Use it if you only need to setup the collector once.
  # include_recipe 'sumologic-collector::cleanup'
end

execute "Deploy Sumo Collector" do
  command node['sumologic']['installerCmd']
  cwd node['sumologic']['installDir']
  timeout 3600
  action :nothing
end
