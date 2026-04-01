# frozen_string_literal: true

# InSpec test for default-resource-install suite

sumo_dir = os.windows? ? 'c:\sumo' : '/opt/SumoCollector'

describe file("#{sumo_dir}/config") do
  it { should exist }
  it { should be_directory }
end

describe file("#{sumo_dir}/config/user.properties") do
  it { should exist }
  its('content') { should match(/accessid=00000000000/) }
  its('content') { should match(/accesskey=0000000000000000000000000/) }
end
