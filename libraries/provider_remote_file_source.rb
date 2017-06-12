# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceRemoteFile < Chef::Provider::SumoSource
      provides :sumo_source_remote_file if respond_to?(:provides)

      def config_hash # rubocop:disable Metrics/AbcSize
        hash = super
        hash['source']['remoteHosts'] = new_resource.remote_hosts
        hash['source']['remotePort'] = new_resource.remote_port
        hash['source']['remoteUser'] = new_resource.remote_user
        hash['source']['remotePassword'] = new_resource.remote_password
        hash['source']['keyPath'] = new_resource.key_path
        hash['source']['keyPassword'] = new_resource.key_password
        hash['source']['pathExpression'] = new_resource.path_expression unless new_resource.path_expression.nil?
        hash['source']['authMethod'] = new_resource.auth_method
        hash['source']['blacklist'] = new_resource.blacklist unless new_resource.blacklist.nil?
        hash
      end
    end
  end
end
