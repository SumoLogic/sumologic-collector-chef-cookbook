require 'chef/provider/lwrp_base'

class Chef
  class Provider
    class SumologicSource < Chef::Provider::LWRPBase
      provides :sumologic_source if defined?(provides)

      use_inline_resources if defined?(use_inline_resources)

      def whyrun_supported?
        true
      end

      action :create do
        directory ::File.dirname new_resource.name do
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
          recursive true
        end

        template new_resource.name do
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
          variables(new_resource.variables)
          source new_resource.source
          cookbook new_resource.cookbook
        end
      end

      action :delete do
        file new_resource.name do
          action :delete
        end
      end
    end
  end
end
