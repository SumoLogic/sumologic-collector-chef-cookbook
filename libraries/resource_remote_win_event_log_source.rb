# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceRemoteWindowsEventLog < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :remote_windows_event_log, equal_to: [:remote_windows_event_log]
      attribute :domain, kind_of: String, required: true
      attribute :username, kind_of: String, required: true
      attribute :password, kind_of: String, required: true
      attribute :hosts, kind_of: Array, required: true
      attribute :log_names, kind_of: Array, required: true
    end
  end
end
