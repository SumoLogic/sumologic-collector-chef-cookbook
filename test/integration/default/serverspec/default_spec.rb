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
    random = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    key = string = (0...50).map { random[rand(random.length)] }.join
    log = Syslog::Logger.new 'Sumologic'
    log.info "this line will be sent to SumoLogic: #{key}"
    sleep(3.minutes)
    collector = Sumologic::Collector.new({ name: 'pd', api_username: node['accessid'], api_password: node['accesskey'] })
    response = collector.search(key)
    expect(!response[0]['_raw'].nil?)
  end

end