# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'
require_relative 'types'

class Chef
  class Provider
    class SumoSourceLocalWindowsEventLog < Chef::Provider::SumoSource
      provides :sumo_source_local_windows_event_log if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['logNames'] = new_resource.log_names
        if new_resource.enable_json_events
          hash['source']['eventFormat'] = EVENT_FORMAT[new_resource.event_format]
          hash['source']['eventMessage'] = EVENT_MESSAGE[new_resource.event_message]
          hash['source']['allowlist'] = new_resource.allowlist
          hash['source']['denylist'] = new_resource.denylist
        end
        hash
      end
    end
  end
end
