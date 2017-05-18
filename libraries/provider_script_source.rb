# frozen_string_literal: true

require 'chef/provider/lwrp_base'
require_relative 'provider_source'

class Chef
  class Provider
    class SumoSourceScript < Chef::Provider::SumoSource
      provides :sumo_source_script if respond_to?(:provides)

      def config_hash # rubocop:disable Metrics/AbcSize
        hash = super
        hash['source']['commands'] = new_resource.commands
        hash['source']['file'] = new_resource.file unless new_resource.file.nil?
        hash['source']['workingDir'] = new_resource.working_dir unless new_resource.working_dir.nil?
        hash['source']['timeout'] = new_resource.timeout unless new_resource.timeout.nil?
        hash['source']['script'] = new_resource.script unless new_resource.script.nil?
        hash['source']['cronExpression'] = new_resource.cron_expression
        hash
      end
    end
  end
end
