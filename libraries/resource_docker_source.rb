# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceDocker < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, required: true, equal_to: %i[docker_stats docker_log]
      attribute :uri, kind_of: String, required: true
      attribute :specified_containers, kind_of: Array
      attribute :all_containers, kind_of: [TrueClass, FalseClass], required: true
      attribute :cert_path, kind_of: String
      attribute :collect_events, kind_of: [TrueClass, FalseClass]
    end
  end
end
