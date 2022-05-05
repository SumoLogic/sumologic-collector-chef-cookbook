# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceRemoteWindowsEventLog < Chef::Provider::SumoSource
      provides :sumo_source_remote_windows_event_log if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['domain'] = new_resource.domain
        hash['source']['username'] = new_resource.username
        hash['source']['password'] = new_resource.password
        hash['source']['hosts'] = new_resource.hosts
        hash['source']['logNames'] = new_resource.log_names
        hash['source']['eventFormat'] = new_resource.event_format
        hash['source']['eventMessage'] = new_resource.event_message
        hash['source']['allowlist'] = new_resource.allowlist
        hash['source']['denylist'] = new_resource.denylist
        hash
      end
    end
  end
end
