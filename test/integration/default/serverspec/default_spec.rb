require_relative 'spec_helper'


describe file('/etc/sumo.conf') do
  it { should contain 'accessid=fakeID' }
  it { should contain 'accesskey=fakeKey' }
end

describe file('/etc/sumo.json') do
  it { should exist }
end

describe package('scalarizr') do
  it { should be_installed }
end

describe file('/opt/SumoCollector') do
  it { should exit }
  it { should be_directory }
end

describe service('collector') do
  it { should be_running }
  it { should be_enabled }
end
