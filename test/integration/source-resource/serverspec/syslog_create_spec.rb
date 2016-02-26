require 'spec_helper'

describe file('/etc/sumo.json/syslog.json') do
  it { is_expected.to exist }
end
