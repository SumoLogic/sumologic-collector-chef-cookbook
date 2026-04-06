# frozen_string_literal: true

sumo_source_script 'syslog' do
  source_json_directory node['sumologic']['sumo_json_path']
  commands ['/bin/bash']
  cron_expression '0 * * * *'
end
