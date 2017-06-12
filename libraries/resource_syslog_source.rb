# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceSyslog < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :syslog, equal_to: [:syslog]
      attribute :protocol, kind_of: String, default: 'UDP'
      attribute :port, kind_of: Integer, default: 514
    end
  end
end
