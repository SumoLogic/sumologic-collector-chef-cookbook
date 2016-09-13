require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceGraphiteMetrics < Chef::Resource::SumoSource
      attribute :source_type, kind_of: Symbol, default: :graphite, equal_to: [:graphite]
      attribute :protocol, kind_of: String, default: 'TCP'
      attribute :port, kind_of: Fixnum, default: 2003
    end
  end
end
