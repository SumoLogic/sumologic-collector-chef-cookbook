require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceSystemMetrics < Chef::Provider::SumoSource
      provides :sumo_source_system_metrics if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['metrics'] = new_resource.metrics unless new_resource.metrics.nil?
        hash['source']['hostName'] = new_resource.hostName unless new_resource.hostName.nil?
        hash['source']['interval'] = new_resource.interval
        hash
      end
    end
  end
end
