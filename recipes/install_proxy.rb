# frozen_string_literal: true

#
# Author:: Brian Oldfield (<brian.oldfield@socrata.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Install Sumo Logic Collector
#
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

# Install Steps:
# 1. Install java
# 2. Download collector tarball
# 3. Expand to /tmp
# 4. Move files into place
# 5. Drop wrapper.config template
# 6. Start collector
#
# Requires /etc/sumo.conf file for automated activation
include_recipe 'sumologic-collector::sumoconf'
include_recipe 'sumologic-collector::sumojson'

# TODO: : Support windows
return unless node['platform'] != 'windows'

Chef::Log.info "  Creating Sumo Logic directory at #{node['sumologic']['installDir']}"

directory node['sumologic']['installDir'] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

Chef::Log.info "  Downloading Sumo Logic Collector from #{node['sumologic']['collectorTarUrl']}"

remote_file "#{Chef::Config[:file_cache_path]}#{node['sumologic']['collectorTarName']}" do
  source node['sumologic']['collectorTarUrl']
  mode '0644'
end

Chef::Log.info "  Installing Sumo Logic collector at #{node['sumologic']['installDir']}"

target = node['kernel']['machine'] =~ /^i[36']86$/ ? 'linux32' : 'linux64'
bash "Expand Sumo Collector" do
  code <<-EOF
  [ ! `pwd` = "/tmp" ] && cd /tmp  # I don't trust the cwd param of bash resources...
  tar xvfz #{node['sumologic']['collectorTarName']}
  [ ! -d sumocollector ] && echo "A problem was encountered extracting sumocollector tarball" && exit 1
  cd sumocollector
  mv ??.*-* #{node['sumologic']['installDir']}/  # not the most precise way of doing it, but good enough for gov't work.
  mv config #{node['sumologic']['installDir']}/
  cp tanuki/#{target}/wrapper #{node['sumologic']['installDir']}/
  cp tanuki/#{target}/libwrapper.so #{node['sumologic']['installDir']}/??.*-*/bin/native/lib/
  mv collector #{node['sumologic']['installDir']}/

  cd #{node['sumologic']['installDir']}
  chmod 554 collector
  chmod 554 wrapper
  ln -s #{node['sumologic']['installDir']}/collector /etc/init.d/collector

  # Clean up
  cd /tmp
  rm #{node['sumologic']['collectorTarName']}
  [ -d sumocollector ] && rm -rf sumocollector # it will be there, I just hate using -rf...
  EOF
  cwd '/tmp'
end

Chef::Log.info "  Updating wrapper.conf to use proxy settings"

template "#{node['sumologic']['installDir']}/config/wrapper.conf" do
  owner 'root'
  group 'root'
  mode '0644'
end

Chef::Log.info "  Starting collector..."

service 'collector' do
  init_command '/etc/init.d/collector'
  supports start: true, status: true, restart: true
  action :start
end
