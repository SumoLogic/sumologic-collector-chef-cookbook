# frozen_string_literal: true

remote_file "#{Chef::Config[:file_cache_path]}/sumocollector.deb" do
  source node['sumologic']['collectorDEBUrl']
end

dpkg_package 'sumocollector' do
  source "#{Chef::Config[:file_cache_path]}/sumocollector.deb"
  action :install
end

if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) >= Gem::Version.new('8.0')
  execute 'sumo-systemd-reload' do
    command '/bin/systemctl --system daemon-reload && /bin/systemctl restart collector.service'
    action :run
    only_if { ::File.exist?('/bin/systemctl') || ::File.exist?('/usr/bin/systemctl') }
    not_if { ::File.exist?('/run/systemd/generator.late/collector.service') }
  end
end
