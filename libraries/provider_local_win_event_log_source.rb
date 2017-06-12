# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceLocalWindowsEventLog < Chef::Provider::SumoSource
      provides :sumo_source_local_windows_event_log if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['logNames'] = new_resource.log_names
        hash
      end
    end
  end
end
