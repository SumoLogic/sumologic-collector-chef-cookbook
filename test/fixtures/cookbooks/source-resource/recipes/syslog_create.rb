# frozen_string_literal: true

sumo_source_syslog 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
end
