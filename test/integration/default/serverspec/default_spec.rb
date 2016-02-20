require 'spec_helper'
require 'sumo_helper'
require 'syslog/logger'

describe file('/etc/sumo.conf') do
  it { should exist }
end

describe file('/etc/sumo.json') do
  it { should exist }
end

describe file('/opt/SumoCollector') do
  it { should be_directory }
end

describe service('collector'), if: os[:family] == 'ubuntu' do
  it { should be_running }
  it { should be_enabled }
end

describe host('service.sumologic.com'), if: os[:family] == 'ubuntu' do
  it { should be_reachable.with(port: 443, proto: 'tcp') }
end
