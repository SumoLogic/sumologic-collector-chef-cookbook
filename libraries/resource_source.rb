# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require 'chef/platform/query_helpers'

class Chef
  class Resource
    class SumoSource < Chef::Resource::LWRPBase
      default_action :create

      actions :create

      attribute :owner, regex: Chef::Config[:user_valid_regex]
      attribute :group, regex: Chef::Config[:group_valid_regex]
      attribute :mode, kind_of: [String, NilClass], default: nil
      attribute :checksum, kind_of: [String, NilClass], default: nil
      attribute :backup, kind_of: [Integer, FalseClass], default: 5
      if Platform.windows?
        attribute :inherits, kind_of: [TrueClass, FalseClass], default: true
        attribute :rights, kind_of: Hash, default: nil
      end

      attribute :source_name, kind_of: String, name_attribute: true
      attribute :source_type, kind_of: Symbol, required: true, equal_to: %i[local_file
                                                                            remote_file
                                                                            local_win_event_log
                                                                            remote_win_event_log
                                                                            syslog
                                                                            script
                                                                            docker_stats
                                                                            graphite]
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
