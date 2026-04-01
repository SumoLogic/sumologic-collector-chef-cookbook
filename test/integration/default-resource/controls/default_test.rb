# frozen_string_literal: true

# InSpec test for default-resource suite

sumo_dir = os.windows? ? 'c:\sumo' : '/opt/SumoCollector'

describe file("#{sumo_dir}/config") do
  it { should exist }
  it { should be_directory }
end
