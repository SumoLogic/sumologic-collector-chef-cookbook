sumo_source_remote_file 'remote_file' do
  source_json_directory node['sumologic']['sumo_json_path']
  remote_hosts ['127.0.0.1']
  remote_port 22
  remote_user 'user'
  remote_password 'password'
  key_path ''
  path_expression '/tmp/example'
  auth_method 'password'
end
