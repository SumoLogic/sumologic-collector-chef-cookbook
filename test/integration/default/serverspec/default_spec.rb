require_relative 'spec_helper'


describe file('/etc/sumo.conf') do
   it { should exist }
end

describe file('/etc/sumo.json') do
  it { should exist }
end

describe file('/opt/SumoCollector') do
  it { should be_directory }
end

describe service('collector') do
  it { should be_running }
  it { should be_enabled }
end
