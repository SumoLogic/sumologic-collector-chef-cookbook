require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumoSourceSystemMetrics < Chef::Resource::SumoSource
      attribute :hostName, kind_of: String 
      attribute :metrics, kind_of: Array 
      attribute :interval, kind_of: Fixnum, default: 60000
    end
  end
end
