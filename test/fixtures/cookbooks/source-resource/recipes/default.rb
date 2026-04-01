# frozen_string_literal: true

# Remove /etc/sumo.json if it exists as a file (left over from the default
# suite running on the same host) before creating it as a directory.
file node['sumologic']['sumo_json_path'] do
  action :delete
  only_if { ::File.file?(node['sumologic']['sumo_json_path']) }
end

directory node['sumologic']['sumo_json_path'] do
  action :create
  recursive true
end
