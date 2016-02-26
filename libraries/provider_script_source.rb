require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumologicCollectorScriptSource < Chef::Provider::SumologicCollectorSource
      provides :sumologic_collector_script_source

      def config_hash
        hash = super
        hash['sources'][0]['commands'] = new_resource.commands
        hash['sources'][0]['file'] = new_resource.file unless new_resource.file.nil?
        hash['sources'][0]['workingDir'] = new_resource.working_dir unless new_resource.working_dir.nil?
        hash['sources'][0]['timeout'] = new_resource.timeout unless new_resource.timeout.nil?
        hash['sources'][0]['script'] = new_resource.script unless new_resource.script.nil?
        hash['sources'][0]['cronExpression'] = new_resource.cron_expression
        hash
      end
    end
  end
end
