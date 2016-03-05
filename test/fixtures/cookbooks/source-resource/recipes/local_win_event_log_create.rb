sumo_source_local_windows_event_log 'local_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
end
