# frozen_string_literal: true

# Inspec test for recipe sumologic-collector::default

# Verify configuration files exist
describe file('/etc/sumo.conf') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/sumo.json') do
  it { should exist }
  it { should be_file }
end

# Verify collector directory exists
describe file('/opt/SumoCollector') do
  it { should exist }
  it { should be_directory }
end

# Verify collector service (Linux only)
only_if('Service tests only run on Linux') do
  os.linux?
end

describe service('collector') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

# Verify network connectivity to Sumo Logic
describe host('service.sumologic.com', port: 443, protocol: 'tcp') do
  it { should be_reachable }
end
