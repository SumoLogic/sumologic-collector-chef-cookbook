require 'chef/resource/lwrp_base'
require_relative 'resource_source'

class Chef
  class Resource
    class SumologicCollectorLocalWinEventLogSource < Chef::Resource::SumologicCollectorSource
      attribute :source_type, kind_of: Symbol, default: :local_win_event_log, equal_to: [:local_win_event_log]
      attribute :log_names, kind_of: Array, required: true
    end
  end
end
