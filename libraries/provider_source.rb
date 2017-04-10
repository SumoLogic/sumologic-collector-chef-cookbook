# frozen_string_literal: true

require 'chef/platform/query_helpers'
require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class SumoSource < Chef::Provider::LWRPBase
      provides :sumo_source if respond_to?(:provides)

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      def load_current_resource
        @current_resource = Chef::Resource::SumoSource.new(new_resource.name)
      end

      action :create do
        file source_json_path do
          content config_json
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
          checksum new_resource.checksum
          backup new_resource.backup
          if Platform.windows?
            inherits new_resource.inherits
            rights new_resource.rights
          end
          # please fix me!
          sensitive(/password/i === config_json) # rubocop:disable Style/CaseEquality
        end
      end

      def api_version
        'v1'
      end

      def config_hash # rubocop:disable Metrics/AbcSize
        hash = {}
        hash['api.version'] = api_version
        hash['source'] = {}
        hash['source']['sourceType'] = source_type_map[new_resource.source_type]
        hash['source']['name'] = new_resource.name
        hash['source']['description'] = new_resource.description unless new_resource.description.nil?
        hash['source']['category'] = new_resource.category unless new_resource.category.nil?
        hash['source']['hostName'] = new_resource.host_name unless new_resource.host_name.nil?
        hash['source']['timeZone'] = new_resource.time_zone unless new_resource.time_zone.nil?
        hash['source']['automaticDateParsing'] = new_resource.automatic_date_parsing unless new_resource.automatic_date_parsing.nil?
        hash['source']['multilineProcessingEnabled'] = new_resource.multiline_processing_enabled unless new_resource.multiline_processing_enabled.nil?
        hash['source']['useAutolineMatching'] = new_resource.use_autoline_matching unless new_resource.use_autoline_matching.nil?
        hash['source']['manualPrefixRegexp'] = new_resource.manual_prefix_regexp unless new_resource.manual_prefix_regexp.nil?
        hash['source']['forceTimeZone'] = new_resource.force_time_zone unless new_resource.force_time_zone.nil?
        hash['source']['defaultDateFormat'] = new_resource.default_date_format unless new_resource.default_date_format.nil?
        hash['source']['filters'] = new_resource.filters unless new_resource.filters.nil?
        hash['source']['alive'] = new_resource.alive unless new_resource.alive.nil?
        hash
      end

      def config_json
        JSON.pretty_generate(config_hash)
      end

      def source_json_path
        "#{new_resource.source_json_directory}/#{new_resource.source_name}.json"
      end

      def source_type_map
        {
          local_file: 'LocalFile',
          remote_file: 'RemoteFile',
          local_windows_event_log: 'LocalWindowsEventLog',
          remote_windows_event_log: 'RemoteWindowsEventLog',
          syslog: 'Syslog',
          script: 'Script',
          docker_stats: 'DockerStats',
          docker_log: 'DockerLog',
          graphite: 'Graphite'
        }
      end
    end
  end
end
