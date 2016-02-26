sumologic_collector_local_win_event_log_source 'local_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names ['security', 'application']
end
