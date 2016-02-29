require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorSyslogSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_syslog_source

      def config_hash
        hash = super
        hash['source']['protocol'] = new_resource.protocol unless new_resource.protocol.nil?
        hash['source']['port'] = new_resource.port
        hash
      end
    end
  end
end
