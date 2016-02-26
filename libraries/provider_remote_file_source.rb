require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorRemoteFileSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_remote_file_source

      def config_hash
        hash = super
        hash['sources'][0]['remoteHosts'] = new_resource.remote_hosts
        hash['sources'][0]['remotePort'] = new_resource.remote_port
        hash['sources'][0]['remoteUser'] = new_resource.remote_user
        hash['sources'][0]['remotePassword'] = new_resource.remote_password
        hash['sources'][0]['keyPath'] = new_resource.key_path
        hash['sources'][0]['keyPassword'] = new_resource.key_password
        hash['sources'][0]['pathExpression'] = new_resource.path_expression unless new_resource.path_expression.nil?
        hash['sources'][0]['authMethod'] = new_resource.auth_method
        hash['sources'][0]['blacklist'] = new_resource.blacklist unless new_resource.blacklist.nil?
        hash
      end
    end
  end
end
