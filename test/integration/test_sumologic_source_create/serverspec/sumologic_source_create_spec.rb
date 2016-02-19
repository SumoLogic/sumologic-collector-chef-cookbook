require 'spec_helper'

describe file '/etc/sumo.d' do
  it { should exist }
  it { should be_directory }
end

describe file '/etc/sumo.d/sumo.json' do
  it { should exist }
end
