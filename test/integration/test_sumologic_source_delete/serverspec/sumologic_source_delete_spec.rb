require 'spec_helper'

describe file '/etc/sumo.d/sumo.json' do
  it { should_not exist }
end
