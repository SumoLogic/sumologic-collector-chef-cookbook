sumo_dir = node['platform_family'] == 'windows' ? 'c:\sumo' : '/opt/SumoCollector'

sumologic_collector sumo_dir do
  action :install
end
