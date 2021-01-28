# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceLocalFile < Chef::Resource::SumoSource
      provides :sumo_source_local_file if respond_to?(:provides)

      attribute :source_type, kind_of: Symbol, default: :local_file, equal_to: [:local_file]
      attribute :path_expression, kind_of: String, required: true
      attribute :blacklist, kind_of: Array
      attribute :encoding, kind_of: String
    end
  end
end
