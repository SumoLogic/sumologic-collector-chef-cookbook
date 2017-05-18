# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceScript < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :script, equal_to: [:script]
      attribute :commands, kind_of: Array, required: true
      attribute :file, kind_of: String
      attribute :working_dir, kind_of: String
      attribute :timeout, kind_of: Integer
      attribute :script, kind_of: String
      attribute :cron_expression, kind_of: String, required: true
    end
  end
end
