require 'spec_helper'

describe file('/etc/sumo.json/system.json') do
  it { is_expected.to exist }
end
