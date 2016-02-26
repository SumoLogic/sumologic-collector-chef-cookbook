require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class SumologicCollectorSource < Chef::Resource::LWRPBase
      default_action :create

      actions :create

      attribute :owner, kind_of: String, default: 'root'
      attribute :group, kind_of: String, default: 'root'
      attribute :mode, kind_of: String, default: '0644'

      attribute :source_name, kind_of: String, name_attribute: true
      attribute :source_type, kind_of: Symbol, required: true, equal_to: [:local_file,
                                                                          :remote_file,
                                                                          :local_win_event_log,
                                                                          :remote_win_event_log,
                                                                          :syslog,
                                                                          :script,
                                                                          :docker_stats]
      attribute :source_json_directory, kind_of: String, required: true
      attribute :description, kind_of: String
      attribute :category, kind_of: String
      attribute :host_name, kind_of: String
      attribute :time_zone, kind_of: String
      attribute :automatic_date_parsing, kind_of: [TrueClass, FalseClass]
      attribute :multiline_processing_enabled, kind_of: [TrueClass, FalseClass]
      attribute :use_autoline_matching, kind_of: [TrueClass, FalseClass]
      attribute :manual_prefix_regexp, kind_of: String
      attribute :force_time_zone, kind_of: [TrueClass, FalseClass]
      attribute :default_date_format, kind_of: String
      attribute :filters, kind_of: Array
      attribute :alive, kind_of: [TrueClass, FalseClass]
    end
  end
end
