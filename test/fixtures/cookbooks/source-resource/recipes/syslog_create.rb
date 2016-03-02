sumo_source_script 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end
