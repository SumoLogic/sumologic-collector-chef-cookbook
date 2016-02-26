require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorLocalWinEventLogSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_local_win_event_log_source

      def config_hash
        hash = super
        hash['sources'][0]['logNames'] = new_resource.log_names
        hash
      end
    end
  end
end
