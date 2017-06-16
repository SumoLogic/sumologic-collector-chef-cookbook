# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceSyslog < Chef::Provider::SumoSource
      provides :sumo_source_syslog if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['protocol'] = new_resource.protocol unless new_resource.protocol.nil?
        hash['source']['port'] = new_resource.port
        hash
      end
    end
  end
end
