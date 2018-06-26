# frozen_string_literal: true

sumo_source_local_file 'local_file_cuttoff_timestamp' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
  cuttoff_timestamp "1529339004"
end

sumo_source_local_file 'local_file_cuttoff_relative_time' do
  source_json_directory node['sumologic']['sumo_json_path']
  path_expression '/tmp/example'
  cuttoff_relative_time '-1d'
end
