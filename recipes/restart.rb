# frozen_string_literal: true

#
# Author::  Duc Ha (<duc@sumologic.com>)
# Cookbook Name:: sumologic-collector
# Recipe:: Restart Sumo Logic Collector, typically for a local configuration collector management change to take effect
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

Chef::Log.info "Restart Collector."
if File.exist? node['sumologic']['installDir']
  Chef::Log.info "Restart Collector at #{node['sumologic']['installDir']}."
else
  Chef::Log.info "Collector Directory is not found at #{node['sumologic']['installDir']}. Will not do anything."
  return
end

execute "Restart Sumo Collector" do
  command node['sumologic']['collectorRestartCmd']
  cwd node['sumologic']['installDir']
  timeout 3600
end
