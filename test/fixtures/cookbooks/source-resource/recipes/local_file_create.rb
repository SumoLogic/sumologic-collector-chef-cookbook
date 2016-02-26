sumologic_collector_local_file_source 'local_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
end
