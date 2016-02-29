require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorRemoteWinEventLogSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_remote_win_event_log_source

      def config_hash
        hash = super
        hash['source']['domain'] = new_resource.domain
        hash['source']['username'] = new_resource.username
        hash['source']['password'] = new_resource.password
        hash['source']['hosts'] = new_resource.hosts
        hash['source']['logNames'] = new_resource.log_names
        hash
      end
    end
  end
end
