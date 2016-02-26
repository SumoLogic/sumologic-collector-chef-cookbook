sumologic_collector_script_source 'script' do
  source_json_directory node['sumologic']['sumo_json_path']
  commands ['/bin/bash']
  cron_expression '0 * * * *'
end
