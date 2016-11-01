# frozen_string_literal: true
sumo_source_graphite 'graphite' do
  source_json_directory node['sumologic']['sumo_json_path']
end
