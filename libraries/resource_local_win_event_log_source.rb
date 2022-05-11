# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'
require_relative 'types'

class Chef
  class Resource
    class SumoSourceLocalWindowsEventLog < Chef::Resource::SumoSource
      provides :sumo_source_local_windows_event_log if respond_to?(:provides)

      attribute :source_type, kind_of: Symbol, default: :local_windows_event_log, equal_to: [:local_windows_event_log]
      attribute :log_names, kind_of: Array, required: true
      attribute :event_format, kind_of: Symbol, default: :legacy, equal_to: EVENT_FORMAT.keys
      attribute :event_message, kind_of: Symbol, default: :message, equal_to: EVENT_MESSAGE.keys
      attribute :allowlist, kind_of: String
      attribute :denylist, kind_of: String
    end
  end
end
