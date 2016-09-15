require 'spec_helper'

describe file('/etc/sumo.json/graphite.json') do
  it { is_expected.to exist }
end
