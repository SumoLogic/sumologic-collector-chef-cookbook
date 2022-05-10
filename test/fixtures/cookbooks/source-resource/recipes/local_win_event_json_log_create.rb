# frozen_string_literal: true

sumo_source_local_windows_event_log 'local_win_event_json_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  log_names %w[security application]

  event_format :legacy
  event_message :message
  allowlist "el1,el2"
  denylist "el3,el4"
end
