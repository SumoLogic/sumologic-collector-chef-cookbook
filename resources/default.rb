# frozen_string_literal: true

# Reference:
# https://service.sumologic.com/help/Default.htm#Using_Quiet_Mode_to_Install_a_Collector.htm

default_action :install_and_configure

actions :install, :install_and_configure, :configure, :remove, :start, :stop, :restart, :enable, :disable

# Installation attributes
attribute :dir, kind_of: String, name_attribute: true
attribute :source, kind_of: String
attribute :runas_username, kind_of: String, default: nil
attribute :winrunas_password, kind_of: String, default: nil
attribute :skip_registration, kind_of: [TrueClass, FalseClass], default: false

# Configuration attributes
attribute :collector_name, kind_of: String, default: nil
attribute :collector_url, kind_of: String, default: nil
attribute :service_retries, kind_of: Integer, default: 0
attribute :service_retry_delay, kind_of: Integer, default: 2
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
attribute :disable_script_source, kind_of: [TrueClass, FalseClass], default: false
attribute :wrapper_java_initmemory, kind_of: Integer
attribute :wrapper_java_maxmemory, kind_of: Integer

# Misc
attribute :installed, kind_of: [TrueClass, FalseClass], default: false
attribute :skip_restart, kind_of: [TrueClass, FalseClass], default: false
