# frozen_string_literal: true

require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceRemoteFile < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :remote_file, equal_to: [:remote_file]
      attribute :remote_hosts, kind_of: Array, required: true
      attribute :remote_port, kind_of: Integer, required: true
      attribute :remote_user, kind_of: String, required: true
      attribute :remote_password, kind_of: String, required: true
      attribute :key_path, kind_of: String, required: true
      attribute :key_password, kind_of: String
      attribute :path_expression, kind_of: String, required: true
      attribute :auth_method, kind_of: String, required: true, equal_to: %w[key password]
      attribute :blacklist, kind_of: Array
    end
  end
end
