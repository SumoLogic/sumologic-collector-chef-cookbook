# frozen_string_literal: true

# InSpec test for windows suite

describe file('c:/sumo') do
  it { should exist }
  it { should be_directory }
end

describe file('c:/sumo/sumo.conf') do
  it { should exist }
end

describe file('c:/sumo/sumo.json') do
  it { should exist }
end
