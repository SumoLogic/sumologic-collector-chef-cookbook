require 'spec_helper'
require 'sumo_helper'


describe file('/etc/sumo.conf') do
<<<<<<< HEAD
  it { should contain 'accessid=' }
  it { should contain 'accesskey=' }
=======
   it { should exist }
>>>>>>> 07c9c18a5aaef29a54f8e396e7613f3066a54989
end

describe file('/etc/sumo.json') do
  it { should exist }
end

describe file('/opt/SumoCollector') do
<<<<<<< HEAD
  it { should exist }
=======
>>>>>>> 07c9c18a5aaef29a54f8e396e7613f3066a54989
  it { should be_directory }
end

describe service('collector') do
  it { should be_running }
  it { should be_enabled }
end

describe host('service.sumologic.com') do
  it { should be_reachable.with( :port => 443, :proto => 'tcp' ) }
end

describe file ('/etc/sumo.conf') do

  it "should receive data" do
    node = load_properties('/etc/sumo.conf')
    puts node
    collector = Sumologic::Collector.new({ name: 'pd', api_username: node['accessid'], api_password: node['accesskey'] })
    response = collector.search('vagrant')
    expect(!response[0]['_raw'].nil?)
  end
end

end