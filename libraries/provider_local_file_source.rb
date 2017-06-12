# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceLocalFile < Chef::Provider::SumoSource
      provides :sumo_source_local_file if respond_to?(:provides)

      def config_hash
        hash = super
        hash['source']['pathExpression'] = new_resource.path_expression unless new_resource.path_expression.nil?
        hash['source']['blacklist'] = new_resource.blacklist unless new_resource.blacklist.nil?
        hash['source']['encoding'] = new_resource.encoding unless new_resource.encoding.nil?
        hash
      end
    end
  end
end
