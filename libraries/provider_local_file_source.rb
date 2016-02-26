require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorLocalFileSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_local_file_source

      def config_hash
        hash = super
        hash['sources'][0]['pathExpression'] = new_resource.path_expression unless new_resource.path_expression.nil?
        hash['sources'][0]['blacklist'] = new_resource.blacklist unless new_resource.blacklist.nil?
        hash['sources'][0]['encoding'] = new_resource.encoding unless new_resource.encoding.nil?
        hash
      end
    end
  end
end
