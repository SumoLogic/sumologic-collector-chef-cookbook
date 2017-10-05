# frozen_string_literal: true

sumo_dir = node['platform_family'] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

# install a blank collector
sumologic_collector sumo_dir do
  action :install
end

sumologic_collector sumo_dir do
  collector_name 'test-instance'
  host_name 'example.com'
  description 'A Test Kitchen instance'
  category 'Misc'
  sumo_access_id node['SUMO_ACCESS_ID']
  sumo_access_key node['SUMO_ACCESS_KEY']
  proxy_host 'proxy.test.com'
  proxy_port 8080
  ephemeral true
  time_zone 'Etc/UTC'
  skip_restart true unless node['SUMO_ACCESS_ID']
  action :configure
end
