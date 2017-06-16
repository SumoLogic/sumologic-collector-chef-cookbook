# frozen_string_literal: true

sumo_dir = node['platform_family'] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

# install a blank collector
sumologic_collector sumo_dir do
  action :install
end

sumologic_collector sumo_dir do
  collector_name 'test-instance'
  sumo_access_id node['SUMO_ACCESS_ID']
  sumo_access_key node['SUMO_ACCESS_KEY']
  proxy_host 'proxy.test.com'
  proxy_port 8080
  ephemeral true
  skip_restart true unless node['SUMO_ACCESS_ID']
  action :configure
end
