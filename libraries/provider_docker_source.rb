require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorDockerSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_docker_source

      def config_hash
        hash = super
        hash['sources'][0]['uri'] = new_resource.uri
        hash['sources'][0]['specifiedContainers'] = new_resource.specified_containers unless new_resource.specified_containers.nil?
        hash['sources'][0]['allContainers'] = new_resource.all_containers
        hash['sources'][0]['certPath'] = new_resource.cert_path unless new_resource.cert_path.nil?
        hash['sources'][0]['sourceType'] = source_type_map[new_resource.source_type]
        hash['sources'][0]['collectEvents'] = new_resource.collect_events unless new_resource.collect_events.nil?
        hash
      end
    end
  end
end
