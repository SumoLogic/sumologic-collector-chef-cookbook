sumologic_collector_remote_win_event_log_source 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names ['security', 'application']
end
