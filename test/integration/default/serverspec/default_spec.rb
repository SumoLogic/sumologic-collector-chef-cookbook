require 'spec_helper'
require 'sumo_helper'

access_id = "suapsWeGL8iczv"
access_key = "8Y2WyLOuwbkKtrQgUQTO3hSodMMBfyLPfw4gxYuhzvcU7yPFUIEXG34MI5FIAbJH"

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

describe host('service.sumologic.com') do
  it { should be_reachable.with( :port => 443, :proto => 'tcp' ) }
end

describe "sumologic" do
  it "should receive data" do
    collector = Sumologic::Collector.new({ name: 'pd', api_username: access_id, api_password: access_key })
    response = collector.search('vagrant')
    expect(!response[0]['_raw'].nil?)
  end
end