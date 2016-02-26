require 'spec_helper'

describe file('/etc/sumo.json/script.json') do
  it { is_expected.to exist }
end
