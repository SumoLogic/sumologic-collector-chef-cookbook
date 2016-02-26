sumologic_collector_syslog_source 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end
