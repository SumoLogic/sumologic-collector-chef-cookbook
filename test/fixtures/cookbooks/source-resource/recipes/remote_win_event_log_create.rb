# frozen_string_literal: true

sumo_source_remote_windows_event_log 'remote_win_event_log' do
  source_json_directory node['sumologic']['sumo_json_path']
  domain 'mydomain'
  username 'user'
  password 'password'
  hosts ['myremotehost1']
  log_names %w[security application]

  event_format :legacy
  event_message :message
  allowlist "el1,el2"
  denylist "el3,el4"
end
