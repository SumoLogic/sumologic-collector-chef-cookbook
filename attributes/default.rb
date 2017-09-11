# frozen_string_literal: true

#
# Author:: Ben Newton (<ben@sumologic.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Default Recipe Attributes
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

# default sumocollector attributes

# Collector Name if not set defaults to chef node name
default['sumologic']['name'] = nil

# Enable Local Configuration Collector Management by default. With this one can update the collector's sources through their local json configuration files.
default['sumologic']['local_management'] =  true
# IMPORTANT: Set this to true if the sumo_json_path is a directory
default['sumologic']['use_json_path_dir'] = false

# Data Bag for Collector Credentials
default['sumologic']['credentials']['bag_name'] = 'sumo-creds'
default['sumologic']['credentials']['item_name'] = 'api-creds'

# Ephemeral node (collector config deleted after 2 days of no heartbeat - data is not deleted from Sumo Logic)
default['sumologic']['ephemeral'] = 'true'

# Default json.conf configuration templates cookbook
# Replace this with a custom cookbook name if you want to create
# your own custom sumo.json or template.
default['sumologic']['json_config_cookbook'] = 'sumologic-collector'

# Default sumo.conf configuration templates cookbook
# Replace this with a custom cookbook name if you want to create
# your own custom sumo.conf template.
default['sumologic']['conf_config_cookbook'] = 'sumologic-collector'

# Default sumo.json template is set to nil so that it's determined in the
# template based on platform_family.  Override this if you want to use a
# custom template name from a custom sumo.json configuration cookbook.
default['sumologic']['json_template'] = nil

# Default sumo.conf template.  Override this if you want to use a custom
# template name from a custom sumo.conf configuration cookbook.
default['sumologic']['conf_template'] = nil

default['sumologic']['max_memory'] = 128

default['sumologic']['use_proxy'] = false
default['sumologic']['proxy'] = {
  'host' => nil,
  'port' => nil
}

default['sumologic']['collectorTarUrl'] = 'https://collectors.sumologic.com/rest/download/tar'
default['sumologic']['collectorTarName'] = 'sumocollector.tar.gz'

# RPMs
default['sumologic']['collectorRPMUrl'] = 'https://collectors.sumologic.com/rest/download/rpm/64'
# DEB
default['sumologic']['collectorDEBUrl'] = 'https://collectors.sumologic.com/rest/download/deb/64'

# Platform Specific Attributes
case node['platform']
# Currently have all linux variants using the scripted installer
when 'redhat', 'centos', 'scientific', 'fedora', 'suse', 'amazon', 'oracle', 'debian', 'ubuntu', 'linux'
  # Install Path
  default['sumologic']['installDir'] = '/opt/SumoCollector'

  # Installer Name
  default['sumologic']['installerName'] = node['kernel']['machine'] =~ /^i[36']86$/ ? 'SumoCollector_linux32.sh' : 'SumoCollector_linux64.sh'

  # Install Command
  default['sumologic']['installerCmd'] = "sh #{default['sumologic']['installerName']} -q -dir #{default['sumologic']['installDir']}"

  # Download Path - Either 32bit or 64bit according to the architecture
  default['sumologic']['downloadURL'] = node['kernel']['machine'] =~ /^i[36']86$/ ? 'https://collectors.sumologic.com/rest/download/linux/32' : 'https://collectors.sumologic.com/rest/download/linux/64'

  # Path to 'sumo.conf'
  default['sumologic']['sumo_conf_path'] = '/etc/sumo.conf'

  # Path to 'sumo.json' or the json directory
  default['sumologic']['sumo_json_path'] = '/etc/sumo.json'
  # default['sumologic']['sumo_json_path'] = '/tmp/JSONDIR'

  # Collector Restart Command
  default['sumologic']['collectorRestartCmd'] = "#{default['sumologic']['installDir']}/collector restart"

  # Syslog source category
  default['sumologic']['syslog_cat'] = 'OS/Linux/System'

  # Security source category
  default['sumologic']['security_cat'] = 'OS/Linux/Security'

when 'windows'
  # Install Path
  default['sumologic']['installDir'] = 'C:/sumo' # We'd like to set this to C:/Program Files/Sumo Logic Collector', but there are issues with the Program Files directory.
  # See this for more info: https://tickets.opscode.com/browse/CHEF-4453

  # Installer Name
  default['sumologic']['installerName'] = node['kernel']['machine'] =~ /^x86_64$/ ? 'SumoCollector_windows-x64.exe' : 'SumoCollector_windows.exe'

  # Install Command
  default['sumologic']['installerCmd'] = "start /wait #{default['sumologic']['installerName']} -q -dir #{default['sumologic']['installDir']}"

  # Download Path - Either 32bit or 64bit according to the architecture
  default['sumologic']['downloadURL'] = node['kernel']['machine'] =~ /^x86_64$/ ? 'https://collectors.sumologic.com/rest/download/win64' : 'https://collectors.sumologic.com/rest/download/windows'

  # Path to 'sumo.conf'
  default['sumologic']['sumo_conf_path'] = 'C:/sumo/sumo.conf'

  # Path to 'sumo.json' or the json directory
  default['sumologic']['sumo_json_path'] = 'C:/sumo/sumo.json'
  # default['sumologic']['sumo_json_path'] = 'C:/sumo/JSONDIR'

  # Collector Restart Command
  default['sumologic']['collectorRestartCmd'] = 'net stop "sumo-collector" && net start "sumo-collector"'
else
  # Just have empty install commands for now as a placeholder

  # Install Path
  default['sumologic']['installDir'] = '/opt/SumoCollector'

  # Installer Name - Either 32bit or 64bit according to the architecture
  default['sumologic']['installerName'] = ''

  # Install Command
  default['sumologic']['installerCmd'] = ''

  # Download Path - Either 32bit or 64bit according to the architecture
  default['sumologic']['downloadURL'] = ''

  # Path to 'sumo.conf'
  default['sumologic']['sumo_conf_path'] = '/etc/sumo.conf'

  # Path to 'sumo.json' or the json directory
  default['sumologic']['sumo_json_path'] = '/etc/sumo.json'
  # default['sumologic']['sumo_json_path'] = '/tmp/JSONDIR'

  # Collector Restart Command
  default['sumologic']['collectorRestartCmd'] = "#{default['sumologic']['installDir']}/collector restart"
end

default['sumologic']['chef_vault_version'] = nil

# if left nil it will defer to ohai to determine, you can
# change the behavior to use a specific init style as long
# as the collector and chef supports it. Consult the chef
# documentation here: https://docs.chef.io/resource_service.html
# for a list of acceptable options. Some examples:
# `Chef::Provider::Service::Systemd`, `Chef::Provider::Service::Upstart`,
# `Chef::Provider::Service::Init::Debian`, etc. Here is
# the source of trusth on supported init subsystemds:
# https://github.com/chef/chef/tree/v13.4.19/lib/chef/provider/service
default['sumologic']['init_style'] = nil
