# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_local_win_event_log_source'

class Chef
  class Provider
    class SumoSourceRemoteWindowsEventLog < Chef::Provider::SumoSourceLocalWindowsEventLog
      provides :sumo_source_remote_windows_event_log if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['domain'] = new_resource.domain
        hash['source']['username'] = new_resource.username
        hash['source']['password'] = new_resource.password
        hash['source']['hosts'] = new_resource.hosts
        hash
      end
    end
  end
end
