use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::SumologicCollectorInstaller.new(new_resource.dir)
  @current_resource.installed(installed?)
end

action :install do
  if @current_resource.installed
    Chef::Log.debug "Sumo Logic Collector already installed to #{new_resource.dir}"
  else

    remote_file "#{Chef::Config[:file_cache_path]}/#{installer_bin}" do
      source new_resource.source
      mode '0755' unless node['platform_family'] == 'windows'
    end

    installer_cmd = [installer_bin, installer_opts].join(' ').strip
    execute 'Install Sumo Collector' do
      command "#{Chef::Config[:file_cache_path]}/#{installer_cmd}"
      timeout 3600
    end

  end
end

private

def installed?
  # The install dir may be created even during a failed installation, so test
  # for a subdirectory that will be present on all platforms and is less
  # likely to exist unless installation was successful.
  ::File.exist?("#{new_resource.dir}/config")
end

def installer_bin
  node['platform_family'] == 'windows' ? 'sumocollector.exe' : 'sumocollector'
end

def installer_opts
  args = []
  args << '-console'
  args << '-q'
  args << "-dir #{new_resource.dir}"
  args << "-Vcollector.name=#{new_resource.collector_name}" unless new_resource.collector_name.nil?
  args << "-Vcollector.url=#{new_resource.collector_url}" unless new_resource.collector_url.nil?
  args << "-Vsumo.email=#{new_resource.sumo_email}" unless new_resource.sumo_email.nil?
  args << "-Vsumo.password=#{new_resource.sumo_password}" unless new_resource.sumo_password.nil?
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
