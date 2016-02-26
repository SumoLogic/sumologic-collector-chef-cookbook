require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class SumologicCollectorSource < Chef::Provider::LWRPBase
      provides :sumologic_collector_source

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        false
      end

      def load_current_resource
        @current_resource = Chef::Resource::SumologicCollectorSource.new(new_resource.name)
      end

      action :create do
        converge_by("Create #{source_json_path}") do
          file source_json_path do
            content config_json
            mode new_resource.mode
            owner new_resource.owner
            group new_resource.group
            sensitive !!(config_json.match(/password/i))
          end
        end
      end

      def api_version
        'v1'
      end

      def config_hash
        hash = {}
        hash['api.version'] = api_version
        hash['sources'] = [{}]
        hash['sources'][0]['sourceType'] = source_type_map[new_resource.source_type]
        hash['sources'][0]['name'] = new_resource.name
        hash['sources'][0]['description'] = new_resource.description unless new_resource.description.nil?
        hash['sources'][0]['category'] = new_resource.category unless new_resource.category.nil?
        hash['sources'][0]['hostName'] = new_resource.host_name unless new_resource.host_name.nil?
        hash['sources'][0]['timeZone'] = new_resource.time_zone unless new_resource.time_zone.nil?
        hash['sources'][0]['automaticDateParsing'] = new_resource.automatic_date_parsing unless new_resource.automatic_date_parsing.nil?
        hash['sources'][0]['multilineProcessingEnabled'] = new_resource.multiline_processing_enabled unless new_resource.multiline_processing_enabled.nil?
        hash['sources'][0]['useAutolineMatching'] = new_resource.use_autoline_matching unless new_resource.use_autoline_matching.nil?
        hash['sources'][0]['manualPrefixRegexp'] = new_resource.manual_prefix_regexp unless new_resource.manual_prefix_regexp.nil?
        hash['sources'][0]['forceTimeSoze'] = new_resource.force_time_zone unless new_resource.force_time_zone.nil?
        hash['sources'][0]['defaultDateFormat'] = new_resource.default_date_format unless new_resource.default_date_format.nil?
        hash['sources'][0]['filters'] = new_resource.filters unless new_resource.filters.nil?
        hash['sources'][0]['alive'] = new_resource.alive unless new_resource.alive.nil?
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
          :local_file => 'LocalFile',
          :remote_file => 'RemoteFile',
          :local_win_event_log => 'LocalWinEventLog',
          :remote_win_event_log => 'RemoteWinEventLog',
          :syslog => 'Syslog',
          :script => 'Script',
          :docker_stats => 'DockerStats',
          :docker_log => 'DockerLog'
        }
      end
    end
  end
end
