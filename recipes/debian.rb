remote_file "#{Chef::Config[:file_cache_path]}/sumocollector.deb" do
  source node['sumologic']['collectorDEBUrl']
end

dpkg_package 'sumocollector' do
  source "#{Chef::Config[:file_cache_path]}/sumocollector.deb"
  action :install
end
