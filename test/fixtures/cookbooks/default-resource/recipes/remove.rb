# frozen_string_literal: true

sumo_dir = node['platform_family'] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

# install a blank collector
sumologic_collector sumo_dir do
  action :install
end

sumologic_collector sumo_dir do
  action :remove
end
