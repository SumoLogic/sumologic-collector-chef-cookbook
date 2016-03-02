sumo_source_local_file 'local_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
end
