# frozen_string_literal: true

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource.resource_for_node(:sumologic_collector, node).new(new_resource.dir)
  @current_resource.installed(installed?)
end

action :install do
  if @current_resource.installed
    Chef::Log.debug "Sumo Logic Collector already installed to #{new_resource.dir}"
  else
    download_installer
    # set up some arguments to allow for unconfigured installation
    new_resource.skip_registration(true)
    new_resource.sumo_access_id('00000000000')
    new_resource.sumo_access_key('0000000000000000000000000')
    installer_cmd = [installer_bin, installer_opts].join(' ').strip
    run_installer installer_cmd
  end
end

action :install_and_configure do
  if @current_resource.installed
    Chef::Log.debug "Sumo Logic Collector already installed to #{new_resource.dir}"
  else
    download_installer
    installer_cmd = [installer_bin, installer_opts].join(' ').strip
    run_installer installer_cmd
  end
end

action :configure do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service
    template "#{new_resource.dir}/config/user.properties" do
      source 'user.properties.erb'
      cookbook 'sumologic-collector'
      variables resource: new_resource
      sensitive true
      unless new_resource.skip_restart
        notifies :configure, new_resource unless ::File.exist?(::File.join(new_resource.dir, 'data'))
        notifies :restart, new_resource
      end
    end
  end
end

action :remove do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    uninstall_cmd = node['platform_family'] == 'windows' ? 'uninstall.exe -console' : './uninstall'
    execute 'Remove Sumologic Collector' do
      command "#{uninstall_cmd} -q"
      cwd new_resource.dir
    end
  end
end

action :start do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service :start
    wait_if_initial_startup
  end
end

action :stop do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service :stop
  end
end

action :restart do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service :restart
    wait_if_initial_startup
  end
end

action :enable do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service :enable
  end
end

action :disable do
  if !@current_resource.installed
    Chef::Log.info "Collector Directory is not found at #{new_resource.dir}. Will not do anything."
  else
    sumo_service :disable
  end
end

private

def installed?
  case node['platform_family']
  when 'windows'
    ::Win32::Service.exists? 'sumo-collector'
  else
    ::File.exist? '/etc/init.d/collector'
  end
end

def installer_bin
  node['platform_family'] == 'windows' ? 'sumocollector.exe' : 'sumocollector'
end

def installer_source
  case node['platform_family']
  when 'windows'
    node['kernel']['machine'] =~ /^x86_64$/ ? 'https://collectors.sumologic.com/rest/download/win64' : 'https://collectors.sumologic.com/rest/download/windows'
  else
    url = 'https://collectors.sumologic.com/rest/download/linux'
    "#{url}/#{node['kernel']['machine'] =~ /^i[36']86$/ ? '32' : '64'}"
  end
end

def download_installer
  if new_resource.source.nil?
    Chef::Log.info "No installer source given, using #{installer_source} instead"
    new_resource.source(installer_source)
  end
  remote_file "#{Chef::Config[:file_cache_path]}/#{installer_bin}" do
    source new_resource.source
    mode '0755' unless node['platform_family'] == 'windows'
  end
end

def run_installer(installer_cmd)
  execute 'Install Sumo Collector' do
    command "#{Chef::Config[:file_cache_path]}/#{installer_cmd}"
    timeout 3600
  end
end

def wait_if_initial_startup
  return if ::File.exist?(::File.join(new_resource.dir, 'data'))

  ruby_block 'Wait for Sumo Collector to register' do
    block do
      SumologicCollector::Helpers.wait_for_registration(new_resource.dir)
    end
  end
end

def sumo_service(action = :nothing)
  service 'sumo-collector' do
    service_name 'collector' unless node['platform_family'] == 'windows'
    retries new_resource.service_retries
    retry_delay new_resource.service_retry_delay
    supports status: true, restart: true
    if Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
      provider Chef::Provider::Service::Systemd
    end
    action action
  end
end

# we should make this more effecient but lets get CI passing again so we can recieve contributions
def installer_opts # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity, CyclomaticComplexity
  args = []
  args << '-console'
  args << '-q'
  args << "-dir #{new_resource.dir}"
  args << "-Vcollector.name=#{new_resource.collector_name}" unless new_resource.collector_name.nil?
  args << "-Vcollector.url=#{new_resource.collector_url}" unless new_resource.collector_url.nil?
  args << "-Vsumo.token_and_url=#{new_resource.sumo_token_and_url}" unless new_resource.sumo_token_and_url.nil?
  args << "-Vsumo.accessid=#{new_resource.sumo_access_id}" unless new_resource.sumo_access_id.nil?
  args << "-Vsumo.accesskey=#{new_resource.sumo_access_key}" unless new_resource.sumo_access_key.nil?
  args << "-Vproxy.host=#{new_resource.proxy_host}" unless new_resource.proxy_host.nil?
  args << "-Vproxy.port=#{new_resource.proxy_port}" unless new_resource.proxy_port.nil?
  args << "-Vproxy.user=#{new_resource.proxy_user}" unless new_resource.proxy_user.nil?
  args << "-Vproxy.password=#{new_resource.proxy_password}" unless new_resource.proxy_password.nil?
  args << "-Vproxy.ntlmdomain=#{new_resource.proxy_ntlmdomain}" unless new_resource.proxy_ntlmdomain.nil?
  args << "-Vsources=#{new_resource.sources}" unless new_resource.sources.nil?
  args << "-VsyncSources=#{new_resource.sync_sources}" unless new_resource.sync_sources.nil?
  args << "-Vephemeral=true" if new_resource.ephemeral
  args << "-Vclobber=true" if new_resource.clobber
  args << "-VrunAs.username=#{new_resource.runas_username}" unless new_resource.runas_username.nil?
  args << "-VwinRunAs.password=#{new_resource.winrunas_password}" unless new_resource.winrunas_password.nil?
  args << "-VskipRegistration=true" if new_resource.skip_registration
  args
end
