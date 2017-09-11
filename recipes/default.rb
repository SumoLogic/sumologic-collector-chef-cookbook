# frozen_string_literal: true

#
# Author:: Ben Newton (<ben@sumologic.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Install, Register, and Configure Collector
#
# Copyright 2013, Sumo Logic
#
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

#
# Sumo Logic Help Links
# https://service.sumologic.com/ui/help/Default.htm#Unattended_Installation_from_a_Linux_Script_using_the_Collector_Management_API.htm
# https://service.sumologic.com/ui/help/Default.htm#Using_sumo.conf.htm
# https://service.sumologic.com/ui/help/Default.htm#JSON_Source_Configuration.htm
#

if File.exist? node['sumologic']['installDir']
  Chef::Log.info "Sumo Logic Collector found."
  # If collector is already in sync source mode, just uncomment these following lines to update the sources
  # include_recipe 'sumologic-collector::sumoconf'
  # if node['sumologic']['use_json_path_dir'] == true
  #	# use the recipe sumojsondir if your source configurations are in a directory
  #	include_recipe 'sumologic-collector::sumojsondir'
  # else
  #	# use the recipe sumojson if your source configurations are in a single json file
  #	include_recipe 'sumologic-collector::sumojson'
  # end
  # include_recipe 'sumologic-collector::restart'
  case node['platform_family']
  when 'rhel', 'amazon', 'linux', 'debian'
    service 'collector' do
      action :start
      provider node['sumologic']['init_style'] unless node['sumologic']['init_style'].nil?
    end
  else
    service 'sumo-collector' do
      action :start
      provider node['sumologic']['init_style'] unless node['sumologic']['init_style'].nil?
    end
  end

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
  include_recipe 'sumologic-collector::install'

  # The following recipe will clean up sumo.conf and the json configuration file(s). Use it if you only need to setup the collector once.
  # include_recipe 'sumologic-collector::cleanup'
end
