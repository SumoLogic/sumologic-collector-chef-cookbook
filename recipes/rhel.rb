# frozen_string_literal: true

remote_file "#{Chef::Config[:file_cache_path]}/sumocollector.rpm" do
  source node['sumologic']['collectorRPMUrl']
end

rpm_package 'sumocollector' do
  source "#{Chef::Config[:file_cache_path]}/sumocollector.rpm"
  action :install
end
