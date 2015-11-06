require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class SumologicConfig < Chef::Resource::LWRPBase
      provides :sumologic_source if defined? provides

      self.resource_name = :sumologic_source
      actions :create, :delete
      default_action :create

      attribute :owner, kind_of: String, default: 'root'
      attribute :group, kind_of: String, default: 'root'
      attribute :mode, kind_of: String, default: '0640'
      attribute :variables, kind_of: [Hash], default: nil
      attribute :source, kind_of: String, default: nil
      attribute :cookbook, kind_of: String, default: nil
    end
  end
end
