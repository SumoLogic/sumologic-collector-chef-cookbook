directory node['sumologic']['sumo_json_path'] do
  action :create
  recursive true
end

sumologic_collector_source 'source' do
  source_type :local_file
  source_json_directory node['sumologic']['sumo_json_path']
end

sumologic_collector_local_file_source 'local_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/lulz'
end

sumologic_collector_remote_file_source 'remote_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  remote_hosts ['127.0.0.1']
  remote_port 22
  remote_user 'user'
  remote_password 'password'
  key_path ''
  path_expression '/tmp/lulz'
  auth_method 'password'
end

sumologic_collector_local_win_event_log_source 'win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
end

sumologic_collector_remote_win_event_log_source 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names ['security', 'application']
end

sumologic_collector_syslog_source 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end

sumologic_collector_script_source 'script' do
  source_json_directory node['sumologic']['sumo_json_path']
  commands ['/bin/bash']
  cron_expression '0 * * * *'
end

sumologic_collector_docker_source 'docker_stats' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_stats
  uri 'https://127.0.0.1:2376'
  all_containers true
end

sumologic_collector_docker_source 'docker_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  source_type :docker_log
  uri 'https://127.0.0.1:2376'
  all_containers true
end
