# frozen_string_literal: true

# Reference:
# https://service.sumologic.com/help/Default.htm#Using_Quiet_Mode_to_Install_a_Collector.htm

default_action :install

actions :install

attribute :dir, kind_of: String, name_attribute: true
attribute :source, kind_of: String
attribute :collector_name, kind_of: String, default: nil
attribute :collector_url, kind_of: String, default: nil
attribute :sumo_email, kind_of: String, default: nil
attribute :sumo_password, kind_of: String, default: nil
attribute :sumo_token_and_url, kind_of: String, default: nil
attribute :sumo_access_id, kind_of: String, default: nil
attribute :sumo_access_key, kind_of: String, default: nil
attribute :proxy_host, kind_of: String, default: nil
attribute :proxy_port, kind_of: [String, Integer], default: nil
attribute :proxy_user, kind_of: String, default: nil
attribute :proxy_password, kind_of: String, default: nil
attribute :proxy_ntlmdomain, kind_of: String, default: nil
attribute :sources, kind_of: String, default: nil
attribute :sync_sources, kind_of: String, default: nil
attribute :ephemeral, kind_of: [TrueClass, FalseClass], default: false
attribute :clobber, kind_of: [TrueClass, FalseClass], default: false
attribute :runas_username, kind_of: String, default: nil
attribute :winrunas_password, kind_of: String, default: nil
attribute :skip_registration, kind_of: [TrueClass, FalseClass], default: false
