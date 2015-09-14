require_relative 'spec_helper'


describe file('/etc/sumo.conf') do
  it { should contain 'accessid=' }
  it { should contain 'accesskey=' }
end

describe file('/etc/sumo.json') do
  it { should exist }
end

describe file('/opt/SumoCollector') do
  it { should exist }
  it { should be_directory }
end

describe service('collector') do
  it { should be_running }
  it { should be_enabled }
end
