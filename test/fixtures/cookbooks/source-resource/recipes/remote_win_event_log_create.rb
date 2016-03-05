sumo_source_remote_windows_event_log 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names ['security', 'application']
end
