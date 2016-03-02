sumo_source_docker 'docker_stats' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_stats
  uri 'https://127.0.0.1:2376'
  all_containers true
end

sumo_source_docker 'docker_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_log
  uri 'https://127.0.0.1:2376'
  all_containers true
end
