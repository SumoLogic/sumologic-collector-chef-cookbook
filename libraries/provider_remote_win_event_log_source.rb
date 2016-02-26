require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorRemoteWinEventLogSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_remote_win_event_log_source

      def config_hash
        hash = super
        hash['sources'][0]['domain'] = new_resource.domain
        hash['sources'][0]['username'] = new_resource.username
        hash['sources'][0]['password'] = new_resource.password
        hash['sources'][0]['hosts'] = new_resource.hosts
        hash['sources'][0]['logNames'] = new_resource.log_names
        hash
      end
    end
  end
end
