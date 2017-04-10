# frozen_string_literal: true

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource.resource_for_node(:sumologic_collector_installer, node).new(new_resource.dir)
end

action :install do
  # just pass on to the new sumo_collector resource
  sumologic_collector new_resource.dir do
    source new_resource.source unless new_resource.source.nil?
    collector_name new_resource.collector_name unless new_resource.collector_name.nil?
    collector_url new_resource.collector_url unless new_resource.collector_url.nil?
    sumo_token_and_url new_resource.sumo_token_and_url unless new_resource.sumo_token_and_url.nil?
    sumo_access_id new_resource.sumo_access_id unless new_resource.sumo_access_id.nil?
    sumo_access_key new_resource.sumo_access_key unless new_resource.sumo_access_key.nil?
    proxy_host new_resource.proxy_host unless new_resource.proxy_host.nil?
    proxy_port new_resource.proxy_port unless new_resource.proxy_port.nil?
    proxy_user new_resource.proxy_user unless new_resource.proxy_user.nil?
    proxy_password new_resource.proxy_password unless new_resource.proxy_password.nil?
    proxy_ntlmdomain new_resource.proxy_ntlmdomain unless new_resource.proxy_ntlmdomain.nil?
    sources new_resource.sources unless new_resource.sources.nil?
    sync_sources new_resource.sync_sources unless new_resource.sync_sources.nil?
    ephemeral new_resource.ephemeral unless new_resource.ephemeral.nil?
    clobber new_resource.clobber unless new_resource.clobber.nil?
    runas_username new_resource.runas_username unless new_resource.runas_username.nil?
    winrunas_password new_resource.winrunas_password unless new_resource.winrunas_password.nil?
    skip_registration new_resource.skip_registration unless new_resource.skip_registration.nil?
  end
end
