# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceLocalWindowsEventLog < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :local_windows_event_log, equal_to: [:local_windows_event_log]
      attribute :log_names, kind_of: Array, required: true
    end
  end
end
