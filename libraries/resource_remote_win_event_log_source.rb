# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceRemoteWindowsEventLog < Chef::Resource::SumoSource
      provides :sumo_source_remote_windows_event_log if respond_to?(:provides)

      attribute :source_type, kind_of: Symbol, default: :remote_windows_event_log, equal_to: [:remote_windows_event_log]
      attribute :domain, kind_of: String, required: true
      attribute :username, kind_of: String, required: true
      attribute :password, kind_of: String, required: true
      attribute :hosts, kind_of: Array, required: true
      attribute :log_names, kind_of: Array, required: true
      attribute :event_format, kind_of: Integer, default: 0, equal_to: [0, 1]
      attribute :event_message, kind_of: Integer, default: 1, equal_to: [0, 1, 2]
      attribute :allowlist, kind_of: String
      attribute :denylist, kind_of: String
    end
  end
end
